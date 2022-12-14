//
//  FirebaseAuthService.swift
//  Armadio
//
//  Created by Bartłomiej on 04/12/2022.
//

import Foundation
import FirebaseAuth
import GoogleSignIn
import Factory

protocol AuthService {
    func restorePreviousSignIn() async -> AuthState
    func signInWithGoogle() async -> AuthState
    func registerWithEmail(email: String, password: String) async -> AuthState
    func signInWithEmail(email: String, password: String) async throws -> AuthState
    func signOut() -> Bool
    func currentUserInfo() -> UserInfo?
}

enum AuthState: Equatable {
    case signedIn(User)
    case signedOut
}

enum FirebaseError: Error {
    case userNotExists
    case somethingWentWrong
}
 
final class FirebaseAuthService: AuthService {
    @Injected(Container.googleSignInAuthProvider) private var googleSignInAuthProvider
    
    func currentUserInfo() -> UserInfo? {
        guard let user = Auth.auth().currentUser else { return nil }
        return UserInfo(uid: user.providerID, email: user.email, displayName: user.displayName, phoneNumber: user.phoneNumber, photo: user.photoURL)
    }
    
    func restorePreviousSignIn() async -> AuthState {
        return await withCheckedContinuation { continuation in
            if let currentUser = Auth.auth().currentUser {
                continuation.resume(returning: .signedIn(currentUser))
            } else {
                continuation.resume(returning: .signedOut)
            }
        }
    }
    
    func signInWithEmail(email: String, password: String) async throws -> AuthState {
        do {
            if Auth.auth().currentUser == nil {
                let user = try await Auth.auth().signIn(withEmail: email, password: password)
                return .signedIn(user.user)
            } else {
                throw FirebaseError.userNotExists
            }
        } catch {
            throw FirebaseError.userNotExists
        }
    }
    
    func registerWithEmail(email: String, password: String) async -> AuthState {
        do {
            if Auth.auth().currentUser == nil {
                let user = try await Auth.auth().createUser(withEmail: email, password: password)
                return .signedIn(user.user)
            } else {
                return .signedOut
            }
        } catch {
            return .signedOut
        }
    }
     
    func signInWithGoogle() async -> AuthState {
        do {
            let user: GIDGoogleUser = try await googleSignInAuthProvider.signIn()
            let authentication = user.authentication
            guard let idToken = authentication.idToken else {
                return .signedOut
            }
            let credential = GoogleAuthProvider.credential(
                withIDToken: idToken,
                accessToken: authentication.accessToken
            )
            do {
                let authDataResult = try await Auth.auth().signIn(with: credential)
                let user = authDataResult.user
                return .signedIn(user)
            } catch {
                return .signedOut
            }
        } catch {
            return .signedOut
        }
    }
     
    func signOut() -> Bool {
        do {
            googleSignInAuthProvider.signOut()
            try Auth.auth().signOut()
            return true
        } catch {
            return false
        }
    }
}
