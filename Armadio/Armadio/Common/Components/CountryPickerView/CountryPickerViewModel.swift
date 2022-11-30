//
//  CountryPickerViewModel.swift
//  Armadio
//
//  Created by Bartłomiej on 30/11/2022.
//

import Foundation
import Factory

final class CountryPickerViewModel: ObservableObject {
    @Injected(Container.countryFlagProvider) private var countryFlagProvider
    
    @Published var isDisplayed = false
    
    // MARK: - CountryFlagService
    
    func getCountryFlag(countryCode: String?) -> String {
        countryFlagProvider.countryFlag(countryCode)
    }
    
    func getCountryName(countryCode: String?) -> String {
        countryFlagProvider.countryName(countryCode)
    }
}
