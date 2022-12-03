//
//  PasswordDetailsViewModel.swift
//  Armadio
//
//  Created by Bartłomiej on 01/12/2022.
//

import Foundation
import Factory

final class PasswordDetailsViewModel: ObservableObject {
    
    @Published var isMainViewPresented = false
    @Published var numberOfShakes = 0.0
    @Published var showingErrorAlert = false
    //User credential
    @Published var passwordText = ""
    @Published var repeatPasswordText = ""
    var userEmail: String
    var userFirstName: String
    var userLastName: String
    var userCountryCode: String?
    
    init(userEmail: String, userFirstName: String, userLastName: String, userCountryCode: String? = nil) {
        self.userEmail = userEmail
        self.userFirstName = userFirstName
        self.userLastName = userLastName
        self.userCountryCode = userCountryCode
    }
    
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
