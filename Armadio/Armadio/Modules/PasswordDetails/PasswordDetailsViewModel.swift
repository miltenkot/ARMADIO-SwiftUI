//
//  PasswordDetailsViewModel.swift
//  Armadio
//
//  Created by Bartłomiej on 01/12/2022.
//

import Foundation

final class PasswordDetailsViewModel: ObservableObject {
    @Published var numberOfShakes = 0.0
    @Published var passwordText = ""
    @Published var repeatPasswordText = ""
    @Published var isMainViewPresented = false
    
    var validateFields: Bool {
        [passwordText, repeatPasswordText].contains(where: { $0.isEmpty }) || !isPasswordValid(passwordText) || !(passwordText == repeatPasswordText)
    }
    
    // MARK: - Shake Animation
    
    func startShakeAnimate() {
        numberOfShakes += 3
    }
    
    func clearShakeAnimate() {
        numberOfShakes = 0
    }
    
    // MARK: - Field validation
    
    func isPasswordValid(_ password : String) -> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
}
