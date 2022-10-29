//
//  SelectYourCountryViewModel.swift
//  Armadio
//
//  Created by Bartłomiej on 27/10/2022.
//

import Foundation

final class SelectYourCountryViewModel: ObservableObject {
    let countryFlagService: CountryFlagProvider
    @Published var isDisplayed = false
    @Published var checkboxState = false
    @Published var countryCode: String? = "AC"
    @Published var isMainViewPresented = false
    @Published var numberOfShakes = 0.0
    
    init(countryFlagService: CountryFlagProvider) {
        self.countryFlagService = countryFlagService
    }
    
    // MARK: - CountryFlagService
    
    func getCountryFlag() -> String {
        countryFlagService.countryFlag(countryCode)
    }
    
    func getCountryName() -> String {
        countryFlagService.countryName(countryCode)
    }
    
    // MARK: - Shake Animation
    
    func startShakeAnimate() {
        numberOfShakes += 3
    }
    
    func clearShakeAnimate() {
        numberOfShakes = 0
    }
}
