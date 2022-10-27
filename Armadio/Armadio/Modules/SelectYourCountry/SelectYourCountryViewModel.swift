//
//  SelectYourCountryViewModel.swift
//  Armadio
//
//  Created by Bartłomiej on 27/10/2022.
//

import Foundation

final class SelectYourCountryViewModel: ObservableObject {
    let countryFlagService: CountryFlagService
    @Published var isDisplayed = false
    @Published var checkboxState = false
    @Published var countryCode: String? = "AC"
    
    init(countryFlagService: CountryFlagService) {
        self.countryFlagService = countryFlagService
    }
    
    func getCountryFlag() -> String {
        countryFlagService.countryFlag(countryCode ?? "")
    }
    
    func getCountryName() -> String {
        countryFlagService.countryName(countryCode ?? "")
    }
}
