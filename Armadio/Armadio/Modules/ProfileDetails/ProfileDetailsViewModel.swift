//
//  ProfileDetailsViewModel.swift
//  Armadio
//
//  Created by Bartłomiej on 30/11/2022.
//

import SwiftUI
import Factory

final class ProfileDetailsViewModel: ObservableObject {
    @Injected(Container.countryFlagProvider) private var countryFlagProvider
    
    @Published var checkboxState = false
    @Published var numberOfShakes = 0.0
    @Published var isDisplayed = false
    @Published var countryCode: String? = "AC"
    @Published var isMainViewPresented = false
    @Published var emailText = ""
    @Published var firstNameText = ""
    @Published var lastNameText = ""
    
    var validateFields: Bool {
        [emailText, firstNameText, lastNameText].contains(where: { $0.isEmpty }) || !checkboxState || !isValidEmailAddress(emailAddressString: emailText)
    }
    
    // MARK: - Shake Animation
    
    func startShakeAnimate() {
        numberOfShakes += 3
    }
    
    func clearShakeAnimate() {
        numberOfShakes = 0
    }
    
    // MARK: - Field validation
    
    private func isValidEmailAddress(emailAddressString: String) -> Bool {
        
        var returnValue = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = emailAddressString as NSString
            let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0
            {
                returnValue = false
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        
        return  returnValue
    }
    
}
