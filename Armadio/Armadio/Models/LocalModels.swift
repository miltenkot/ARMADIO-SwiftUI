//
//  LocalClothe.swift
//  Armadio
//
//  Created by Bartłomiej on 29/10/2022.
//

import Foundation
import SwiftUI

struct LocalClothe: Hashable, Codable, Identifiable {
    var brand: String?
    var dateOfPurchase: Date?
    var desc: String?
    var id: UUID?
    var image: Data?
    var material: String?
    var size: String?
    var price: LocalPrice?
    var category: LocalCategory?
    var receipt: LocalReceipt?
    var color: Color?
    
    init(brand: String? = nil, dateOfPurchase: Date? = nil, desc: String? = nil, id: UUID? = nil, image: Data? = nil, material: String? = nil, size: String? = nil, price: LocalPrice? = nil, category: LocalCategory? = nil, receipt: LocalReceipt? = nil, color: Color? = nil) {
        self.brand = brand
        self.dateOfPurchase = dateOfPurchase
        self.desc = desc
        self.id = id
        self.image = image
        self.material = material
        self.size = size
        self.price = price
        self.category = category
        self.receipt = receipt
        self.color = color
    }
    
    init(from object: Clothe) {
        self.brand = object.brand
        self.dateOfPurchase = object.dateOfPurchase
        self.desc = object.description
        self.id = object.id
        self.image = object.image
        self.material = object.material
        self.size = object.size
        self.price?.amount = object.price?.amount ?? 0.00
        self.price?.currency = object.price?.currency ?? .pln
        self.category?.name = object.category?.name
        self.category?.subcategory?.name = object.category?.subcategory?.name
        self.receipt?.image = object.receipt?.image
        self.color = object.color
    }
}

struct LocalCategory: Hashable, Codable {
    var name: String?
    var subcategory: LocalSubcategory?
}

struct LocalSubcategory: Hashable, Codable {
    var name: String?
}

struct LocalPrice: Hashable, Codable {
    var amount: Double
    var currency: Currency
}

struct LocalReceipt: Hashable, Codable {
    var image: Data?
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
