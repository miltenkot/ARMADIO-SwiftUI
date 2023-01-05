//
//  AuthenticationViewModel.swift
//  Armadio
//
//  Created by Bartłomiej on 04/12/2022.
//

import Foundation
import FirebaseAuth
import Factory
import AuthenticationServices
import CryptoKit

/// A class conforming to `ObservableObject` used to represent a user's authentication status.
final class AuthenticationViewModel: ObservableObject {
    @Injected(Container.firebaseAuthService) private var firebaseAuthService
    
    /// The user's log in status.
    /// - note: This will publish updates when its value changes.
    @Published var state: AuthState
    @Published var errorMessage = ""
    @Published var displayName = ""
    
    private var currentNonce: String?
    
    /// Creates an instance of this view model.
    init() {
        self.state = .signedOut
    }
    
    /// User info fetched from `FIRUser` firebase framework
    /// - Returns: mapped `FIRUser` to UserInfo object
    func currentUserInfo() -> UserInfo? {
        firebaseAuthService.currentUserInfo()
    }
    
    
    /// Restore previous valid auth state `signedIn` or `signedOut`
    func restorePreviousSignIn() {
        Task {
            let state = await firebaseAuthService.restorePreviousSignIn()
            await MainActor.run(body: { [weak self] in
                self?.state = state
            })
        }
    }
    
    /// Signs the user in with Google
    func signInWithGoogle() {
        Task {
            let state = await firebaseAuthService.signInWithGoogle()
            await MainActor.run(body: { [weak self] in
                self?.state = state
            })
        }
    }
    
    /// Signs the user in with basic auth process email + password
    func signInWithEmail(email: String, password: String) async -> Result<Void, Error> {
        if let state = try? await firebaseAuthService.signInWithEmail(email: email, password: password) {
            await MainActor.run(body: { [weak self] in
                self?.state = state
            })
            return .success(())
        } else {
            return .failure(FirebaseError.userNotExists)
        }
    }
    
    /// Register the user in with basic auth process email + password
    func registerWithEmail(email: String, password: String) {
        Task {
            let state = await firebaseAuthService.registerWithEmail(email: email, password: password)
            await MainActor.run(body: { [weak self] in
                self?.state = state
            })
        }
    }
    
    /// Signs the user out.
    func signOut() {
        if firebaseAuthService.signOut() {
            self.state = .signedOut
        }
    }
}

// MARK: - Apple authorization
extension AuthenticationViewModel {
    func handleSignInWithAppleRequest(_ request: ASAuthorizationAppleIDRequest) {
      request.requestedScopes = [.fullName, .email]
      let nonce = randomNonceString()
      currentNonce = nonce
      request.nonce = sha256(nonce)
    }
    
    func handleSignInWithAppleCompletion(_ result: Result<ASAuthorization, Error>) {
      if case .failure(let failure) = result {
        errorMessage = failure.localizedDescription
      }
      else if case .success(let authorization) = result {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
          guard let nonce = currentNonce else {
            fatalError("Invalid state: a login callback was received, but no login request was sent.")
          }
          guard let appleIDToken = appleIDCredential.identityToken else {
            print("Unable to fetdch identify token.")
            return
          }
          guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
            print("Unable to serialise token string from data: \(appleIDToken.debugDescription)")
            return
          }

          let credential = OAuthProvider.credential(withProviderID: "apple.com",
                                                    idToken: idTokenString,
                                                    rawNonce: nonce)
          Task {
            do {
              let result = try await Auth.auth().signIn(with: credential)
              await updateDisplayName(for: result.user, with: appleIDCredential)
            }
            catch {
              print("Error authenticating: \(error.localizedDescription)")
            }
          }
        }
      }
    }
    
    func updateDisplayName(for user: User, with appleIDCredential: ASAuthorizationAppleIDCredential, force: Bool = false) async {
      if let currentDisplayName = Auth.auth().currentUser?.displayName, !currentDisplayName.isEmpty {
        // current user is non-empty, don't overwrite it
      }
      else {
        let changeRequest = user.createProfileChangeRequest()
        changeRequest.displayName = appleIDCredential.displayName()
        do {
          try await changeRequest.commitChanges()
          self.displayName = Auth.auth().currentUser?.displayName ?? ""
        }
        catch {
          print("Unable to update the user's displayname: \(error.localizedDescription)")
          errorMessage = error.localizedDescription
        }
      }
    }
    
    private func randomNonceString(length: Int = 32) -> String {
      precondition(length > 0)
      let charset: [Character] =
      Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
      var result = ""
      var remainingLength = length

      while remainingLength > 0 {
        let randoms: [UInt8] = (0 ..< 16).map { _ in
          var random: UInt8 = 0
          let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
          if errorCode != errSecSuccess {
            fatalError(
              "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
            )
          }
          return random
        }

        randoms.forEach { random in
          if remainingLength == 0 {
            return
          }

          if random < charset.count {
            result.append(charset[Int(random)])
            remainingLength -= 1
          }
        }
      }

      return result
    }

    private func sha256(_ input: String) -> String {
      let inputData = Data(input.utf8)
      let hashedData = SHA256.hash(data: inputData)
      let hashString = hashedData.compactMap {
        String(format: "%02x", $0)
      }.joined()

      return hashString
    }
}

// MARK: - ASAuthorizationAppleIDCredential
extension ASAuthorizationAppleIDCredential {
  func displayName() -> String {
    return [self.fullName?.givenName, self.fullName?.familyName]
      .compactMap( {$0})
      .joined(separator: " ")
  }
}
