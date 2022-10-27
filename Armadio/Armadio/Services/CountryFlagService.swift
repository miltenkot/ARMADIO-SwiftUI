//
//  CountryFlagService.swift
//  Armadio
//
//  Created by Bartłomiej on 27/10/2022.
//

import Foundation

protocol CountryFlagService {
    func countryFlag(_ countryCode: String) -> String
    func countryName(_ countryCode: String) -> String
}

final class CountryFlagServiceImpl: CountryFlagService {
    
    func countryName(_ countryCode: String) -> String {
        Locale.current.localizedString(forRegionCode: countryCode) ?? ""
    }
    
    func countryFlag(_ countryCode: String) -> String {
        String(String.UnicodeScalarView(countryCode.unicodeScalars.compactMap {
            UnicodeScalar(127397 + $0.value)
        }))
    }
}
