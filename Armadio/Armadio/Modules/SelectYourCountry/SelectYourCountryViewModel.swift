//
//  SelectYourCountryViewModel.swift
//  Armadio
//
//  Created by Bartłomiej on 27/10/2022.
//

import Foundation
import Factory

/// Provide shake animation and country flag properties.
final class SelectYourCountryViewModel: ObservableObject {
    
    @Published var checkboxState = false
    @Published var numberOfShakes = 0.0
    @Published var countryCode: String? = "AC"
    @Published var isMainViewPresented = false
    
    // MARK: - Shake Animation
    
    func startShakeAnimate() {
        numberOfShakes += 3
    }
    
    func clearShakeAnimate() {
        numberOfShakes = 0
    }
}
