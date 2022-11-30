//
//  LoginOptionsViewModel.swift
//  Armadio
//
//  Created by Bartłomiej on 28/10/2022.
//

import Foundation

final class LoginOptionsViewModel: ObservableObject {
    @Published var activeModalView: ModalView? = nil
    
    enum ModalView: String, Identifiable {
        case apple, facebook, google, email, guest
        
        var id: String {
            return self.rawValue
        }
    }
}
