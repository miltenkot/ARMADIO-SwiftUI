//
//  SelectYourCountryViewModel.swift
//  Armadio
//
//  Created by Bartłomiej on 27/10/2022.
//

import Foundation
import Factory

final class SelectYourCountryViewModel: ObservableObject {
    @Injected(Container.countryFlagProvider) private var countryFlagProvider
    
    @Published var isDisplayed = false
    @Published var checkboxState = false
    @Published var countryCode: String? = "AC"
    @Published var isMainViewPresented = false
    @Published var numberOfShakes = 0.0
    
    // MARK: - CountryFlagService
    
    func getCountryFlag() -> String {
        countryFlagProvider.countryFlag(countryCode)
    }
    
    func getCountryName() -> String {
        countryFlagProvider.countryName(countryCode)
    }
    
    // MARK: - Shake Animation
    
    func startShakeAnimate() {
        numberOfShakes += 3
    }
    
    func clearShakeAnimate() {
        numberOfShakes = 0
    }
}
