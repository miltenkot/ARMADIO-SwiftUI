//
//  AuthenticationViewModel.swift
//  Armadio
//
//  Created by Bartłomiej on 04/12/2022.
//

import Foundation
import FirebaseAuth
import Factory

/// A class conforming to `ObservableObject` used to represent a user's authentication status.
final class AuthenticationViewModel: ObservableObject {
    @Injected(Container.firebaseAuthService) private var firebaseAuthService
    
    /// The user's log in status.
    /// - note: This will publish updates when its value changes.
    @Published var state: AuthState
    
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
