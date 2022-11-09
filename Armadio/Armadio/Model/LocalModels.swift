//
//  LocalClothe.swift
//  Armadio
//
//  Created by Bartłomiej on 29/10/2022.
//

import Foundation
import SwiftUI

struct LocalCategory: Hashable, Codable {
    var name: String
    var subcategory: LocalSubcategory
}

struct LocalSubcategory: Hashable, Codable {
    var name: String
}

struct LocalPrice: Hashable, Codable {
    var amount: Double
    var currency: Currency
}

enum Currency: String, Codable, CaseIterable {
    case eur
    case usd
    case sek
    case pln
}

extension LocalPrice: CustomStringConvertible {
    var description: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = currency.rawValue
        formatter.maximumFractionDigits = 2
        
        let number = NSNumber(value: amount)
        return formatter.string(from: number) ?? "None"
    }
}

struct ClotheCategory: Hashable, Codable {
    var name: String
    var subcategories: [LocalSubcategory]
}

extension ClotheCategory {
    static var categoriesMock: [ClotheCategory] = [.init(name: "Category1", subcategories: [.init(name: "Suby1cc"),
                                                                                            .init(name: "Suby1ss")]),
                                                   .init(name: "Category2", subcategories: [.init(name: "Suby2aa"),
                                                                                            .init(name: "Suby2ss"),
                                                                                            .init(name: "Suby2dd"),
                                                                                            .init(name: "Suby2cc")]),
                                                   .init(name: "Category3", subcategories: [.init(name: "Suby3rr"),
                                                                                            .init(name: "Suby3yy"),
                                                                                            .init(name: "Suby3tt"),
                                                                                            .init(name: "Suby3rr"),
                                                                                            .init(name: "Suby3uu")])]
}
