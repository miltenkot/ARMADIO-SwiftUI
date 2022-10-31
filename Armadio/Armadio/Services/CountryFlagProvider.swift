//
//  CountryFlagProvider.swift
//  Armadio
//
//  Created by Bartłomiej on 27/10/2022.
//

import Foundation

protocol CountryFlagProvider {
    func countryFlag(_ countryCode: String?) -> String
    func countryName(_ countryCode: String?) -> String
}

final class CountryFlagProviderImpl: CountryFlagProvider {
    
    func countryName(_ countryCode: String?) -> String {
        guard let countryCode else { return "" }
        return Locale.current.localizedString(forRegionCode: countryCode) ?? ""
    }
    
    func countryFlag(_ countryCode: String?) -> String {
        guard let countryCode else { return "" }
        return String(String.UnicodeScalarView(countryCode.unicodeScalars.compactMap {
            UnicodeScalar(127397 + $0.value)
        }))
    }
}

// MARK: - Mocks

final class CountryFlagProviderMock: CountryFlagProvider {
    func countryFlag(_ countryCode: String?) -> String {
        String(String.UnicodeScalarView("AT".unicodeScalars.compactMap {
            UnicodeScalar(127397 + $0.value)
        }))
    }
    
    func countryName(_ countryCode: String?) -> String {
        Locale.current.localizedString(forRegionCode: "AT") ?? ""
    }
}
