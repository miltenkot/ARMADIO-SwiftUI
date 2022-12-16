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

protocol GoogleSignInAuthProvider {
    func signIn() async throws -> GIDGoogleUser
    func signOut()
}

final class GoogleSignInAuthProviderImpl: GoogleSignInAuthProvider {
    private let clientID = (Bundle.main.object(forInfoDictionaryKey: "CLIENT_ID") as? String) ?? ""
    
    private lazy var configuration: GIDConfiguration = {
        return GIDConfiguration(clientID: clientID)
    }()
    
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
    
    func signOut() {
        GIDSignIn.sharedInstance.signOut()
    }
}
