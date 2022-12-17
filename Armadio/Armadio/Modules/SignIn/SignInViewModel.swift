//
//  SignInViewModel.swift
//  Armadio
//
//  Created by Bartłomiej on 04/12/2022.
//

import Foundation

/// Validate `email` and `password` fields and provide Shake animations.
final class SignInViewModel: ObservableObject {
    @Published var emailText = ""
    @Published var passwordText = ""
    @Published var numberOfShakes = 0.0
    @Published var showingErrorAlert = false
    
    var validateFields: Bool {
        [emailText, passwordText].contains(where: { $0.isEmpty })
    }
    
    // MARK: - Shake Animation
    
    func startShakeAnimate() {
        numberOfShakes += 3
    }
    
    func clearShakeAnimate() {
        numberOfShakes = 0
    }
}
