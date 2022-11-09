//
//  Injection.swift
//  Armadio
//
//  Created by Bartlomiej Lanczyk on 30/10/2022.
//

import Factory
import CoreData

extension Container {
    static let countryFlagProvider = Factory<CountryFlagProvider> { CountryFlagProviderImpl() }
    static let firebaseAnaliticsProvider = Factory<FirebaseAnaliticsProvider> { FirebaseAnaliticsProviderImpl() }
    static let clotheDataProvider = Factory<ClotheDataProvider> { ClotheDataProviderImpl() }
}

//MARK: Unit tests helpers

extension Container {
    static func setupMocks() {
        countryFlagProvider.register { CountryFlagProviderMock() }
    }
}
