//
//  CountryListViewModel.swift
//  Armadio
//
//  Created by Bartłomiej on 27/10/2022.
//

import Foundation
import Factory

/// Provide names and flags image to view.
final class CountryListViewModel: ObservableObject {
    @Injected(Container.countryFlagProvider) private var countryFlagProvider
    
    func getCountryFlag(_ countryCode: String?) -> String {
        countryFlagProvider.countryFlag(countryCode)
    }
    
    func getCountryName(_ countryCode: String?) -> String {
        countryFlagProvider.countryName(countryCode)
    }
}
