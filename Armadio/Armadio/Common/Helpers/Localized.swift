//
//  Localized.swift
//  Armadio
//
//  Created by Bartłomiej on 28/10/2022.
//

import Foundation

extension String {
    
    public var localized: String {
        NSLocalizedString(self, comment: "")
    }
}
