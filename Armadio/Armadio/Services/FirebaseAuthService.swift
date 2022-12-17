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

/// Methods that provide firebase authentication functionality.
protocol AuthService {
    func restorePreviousSignIn() async -> AuthState
    func signInWithGoogle() async -> AuthState
    func registerWithEmail(email: String, password: String) async -> AuthState
    func signInWithEmail(email: String, password: String) async throws -> AuthState
    func signOut() -> Bool
    func currentUserInfo() -> UserInfo?
}

/// Authentication states.
enum AuthState: Equatable {
    case signedIn(User)
    case signedOut
}

/// Authentication possiby errors.
enum FirebaseError: Error {
    case userNotExists
    case somethingWentWrong
}
 
/// A class conforming to `AuthService` used to wrap `GoogleSignIn` and `FirebaseAuth` framework and provide authentication functionality.
final class FirebaseAuthService: AuthService {
    @Injected(Container.googleSignInAuthProvider) private var googleSignInAuthProvider
    
    /// Get the data of the currently logged in user.
    /// - Returns: `UserInfo` struct which wrap `FIRUser`
    func currentUserInfo() -> UserInfo? {
        guard let user = Auth.auth().currentUser else { return nil }
        return UserInfo(uid: user.providerID, email: user.email, displayName: user.displayName, phoneNumber: user.phoneNumber, photo: user.photoURL)
    }
    
    
    /// Restore Previous SignIn state.
    /// - Returns: correct `AuthState`
    func restorePreviousSignIn() async -> AuthState {
        return await withCheckedContinuation { continuation in
            if let currentUser = Auth.auth().currentUser {
                continuation.resume(returning: .signedIn(currentUser))
            } else {
                continuation.resume(returning: .signedOut)
            }
        }
    }
    
    /// Perform `singIn(withEmail:` Firebase framework method using user credentials.
    /// - Parameters:
    ///   - email: string representation of user email
    ///   - password: string representation of user password
    /// - Returns: `AuthState` .signedIn which contains `currentUser`
    /// - Throws: `FirebaseError.userNotExists` when user not exists
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
    
    
    /// Perform `createUser(withEmail:` Firebase framework method using user credentials.
    /// - Parameters:
    ///   - email: string representation of user email
    ///   - password: string representation of user password
    /// - Returns: `AuthState` .signedIn which contains `currentUser` or .signedOut when failed
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
    
    /// Perform .signIn method from `GoogleSignInAuthProvider`.
    /// - Returns: `AuthState` .signedIn which contains `currentUser` or .signedOut when failed
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
    
    /// SignOut from any auth services.
    /// - Returns: `true` if logout was successful `false` if there was a problem
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
