//
//  Injection.swift
//  Armadio
//
//  Created by Bartlomiej Lanczyk on 30/10/2022.
//

import Factory

extension Container {
    static let countryFlagProvider = Factory<CountryFlagProvider> { CountryFlagProviderImpl() }
}

//MARK: Unit tests helpers

extension Container {
    static func setupMocks() {
        countryFlagProvider.register { CountryFlagProviderMock() }
    }
}
