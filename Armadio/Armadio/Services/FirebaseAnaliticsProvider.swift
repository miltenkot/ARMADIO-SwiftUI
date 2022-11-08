//
//  FirebaseAnalitics.swift
//  Armadio
//
//  Created by Bartłomiej on 08/11/2022.
//

import Foundation
import Firebase

protocol FirebaseAnaliticsProvider {
    func logSaveAction(amount: String)
}

final class FirebaseAnaliticsProviderImpl: FirebaseAnaliticsProvider {
    
    func logSaveAction(amount: String) {
        FirebaseAnalytics.Analytics.logEvent("add_new_clothe_save_button_tapped",
                                             parameters: [AnalyticsParameterScreenName: "add_new_clothe_view",
                                                          "clothe_price": amount])
    }
    
}
