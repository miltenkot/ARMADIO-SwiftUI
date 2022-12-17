//
//  FirebaseAnalitics.swift
//  Armadio
//
//  Created by Bartłomiej on 08/11/2022.
//

import Foundation
import Firebase

/// Methods that provide firebase analitics functionality.
protocol FirebaseAnaliticsProvider {
    func logSaveAction(amount: String)
}

/// A class conforming to `FirebaseAnaliticsProvider` used to work with firebase analitics.
final class FirebaseAnaliticsProviderImpl: FirebaseAnaliticsProvider {
    
    /// Get and print in console logs after user save new clothe.
    /// - Parameter amount: `String` representation of price amout saved clothe
    func logSaveAction(amount: String) {
        FirebaseAnalytics.Analytics.logEvent("add_new_clothe_save_button_tapped",
                                             parameters: [AnalyticsParameterScreenName: "add_new_clothe_view",
                                                          "clothe_price": amount])
    }
    
}
