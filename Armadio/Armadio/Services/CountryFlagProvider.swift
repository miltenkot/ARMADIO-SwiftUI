//
//  CountryFlagProvider.swift
//  Armadio
//
//  Created by Bartłomiej on 27/10/2022.
//

import Foundation

/// Methods that provide country flags functionality.
protocol CountryFlagProvider {
    func countryFlag(_ countryCode: String?) -> String
    func countryName(_ countryCode: String?) -> String
}

/// A class conforming to `CountryFlagProvider` used to implement country flags functionality.
final class CountryFlagProviderImpl: CountryFlagProvider {
    
    /// Get coutry name
    /// - Parameter countryCode: specific coutry code as `String` e.g. `AC`
    /// - Returns: name of specific country e.g `Poland`.
    func countryName(_ countryCode: String?) -> String {
        guard let countryCode else { return "" }
        return Locale.current.localizedString(forRegionCode: countryCode) ?? ""
    }
    
    /// Get image of coutry flag
    /// - Parameter countryCode: specific coutry code as `String` e.g. `AC`
    /// - Returns: string representation of emoji with country image e.g. `🇵🇱`
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
