//
//  CountryListViewModel.swift
//  Armadio
//
//  Created by Bartłomiej on 27/10/2022.
//

import Foundation

final class CountryListViewModel: ObservableObject {
    let countryFlagService: CountryFlagProvider
    
    init(countryFlagService: CountryFlagProvider) {
        self.countryFlagService = countryFlagService
    }
    
    func getCountryFlag(_ countryCode: String?) -> String {
        countryFlagService.countryFlag(countryCode)
    }
    
    func getCountryName(_ countryCode: String?) -> String {
        countryFlagService.countryName(countryCode)
    }
}
