//
//  GoogleSignInAuthProvider.swift
//  Armadio
//
//  Created by Bartłomiej on 04/12/2022.
//

import SwiftUI
import GoogleSignIn
import Foundation
import FirebaseAuth

/// Methods that provide google authentication functionality.
protocol GoogleSignInAuthProvider {
    func signIn() async throws -> GIDGoogleUser
    func signOut()
}

/// A class conforming to `GoogleSignInAuthProvider` used to wrap `GoogleSignIn` and `FirebaseAuth` framework and provide sign in and sign out functionality.
final class GoogleSignInAuthProviderImpl: GoogleSignInAuthProvider {
    /// clientId used to work with authentication framewok which looks like`xyz.apps.googleusercontent.com`.
    private let clientID = (Bundle.main.object(forInfoDictionaryKey: "CLIENT_ID") as? String) ?? ""
    
    /// GIDConfiguration which used our `clientID`.
    private lazy var configuration: GIDConfiguration = {
        return GIDConfiguration(clientID: clientID)
    }()
    
    /// Display popup on our root view for logging in via google.
    /// - Returns: `GIDGoogleUser` if success and `FirebaseError.somethingWentWrong` when failure
    @MainActor
    func signIn() async throws -> GIDGoogleUser {
        guard let rootViewController = UIApplication.keyWindow?.rootViewController else {
            throw FirebaseError.userNotExists
        }
        return try await withCheckedThrowingContinuation { continuation in
            GIDSignIn.sharedInstance.signIn(
                with: configuration,
                presenting: rootViewController
            ) { user, error in
                guard let user = user else {
                    continuation.resume(with: .failure(FirebaseError.somethingWentWrong))
                    return
                }
                continuation.resume(with: .success(user))
            }
        }
    }
    
    /// SignOut current user from app.
    func signOut() {
        GIDSignIn.sharedInstance.signOut()
    }
}
