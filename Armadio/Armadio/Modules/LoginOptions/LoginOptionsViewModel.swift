//
//  LoginOptionsViewModel.swift
//  Armadio
//
//  Created by Bartłomiej on 28/10/2022.
//

import Foundation

final class LoginOptionsViewModel: ObservableObject {
    @Published var activeModalView: ModalView? = nil
    @Published var facebookLoginNotAvailable = false
    @Published var appleLoginNotAvailable = false
    
    enum ModalView: String, Identifiable {
        case email, guest
        
        var id: String {
            return self.rawValue
        }
    }
}
