//
//  SingleClothe.swift
//  Armadio
//
//  Created by Bartłomiej on 29/10/2022.
//

import Foundation
import SwiftUI

struct Clothe: Hashable, Codable, Identifiable {
    var id: Int
    var price: Price
    var size: String
    var category: Category
    var color: Color
    var material: String
    var description: String
    var brand: String
    var dateOfPurchase: Date
    var receipt: Receipt?
    
    private var imageName: String
    var image: Image {
        Image(imageName)
    }
}

struct Category: Hashable, Codable {
    var name: String
    var subcategory: Subcategory
}

struct Subcategory: Hashable, Codable {
    var name: String
}

struct Price: Hashable, Codable {
    var amount: Double
    var currency: Currency
}

enum Currency: String, Codable, CaseIterable {
    case eur
    case usd
    case sek
    case pln
}

extension Price: CustomStringConvertible {
    var description: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = currency.rawValue
        formatter.maximumFractionDigits = 2
        
        let number = NSNumber(value: amount)
        return formatter.string(from: number) ?? "None"
    }
}

extension Clothe {
    static var clothesMock: [Clothe] = [
        .init(id: 1, price: .init(amount: 300, currency: .pln), size: "M", category: Category(name: "Bottoms", subcategory: .init(name: "Short")), color: .red, material: "Chiffon", description: "Nice clothe", brand: "Gucci", dateOfPurchase: .now, receipt: nil, imageName: "clothe1"),
        .init(id: 2, price: .init(amount: 500, currency: .eur), size: "L", category: Category(name: "Accessories", subcategory: .init(name: "Drop")), color: .yellow, material: "Cotton", description: "Elegance", brand: "Gucci", dateOfPurchase: .now, receipt: nil, imageName: "clothe2"),
        .init(id: 3, price: .init(amount: 1000, currency: .eur), size: "XXL", category: Category(name: "Accessories", subcategory: .init(name: "XYZ")), color: .blue, material: "Crepe", description: "OMG Awesome", brand: "Gucci", dateOfPurchase: .now, receipt: nil, imageName: "clothe3"),
        .init(id: 4, price: .init(amount: 600, currency: .pln), size: "S", category: Category(name: "Dresses", subcategory: .init(name: "Seldom")), color: .black, material: "Denim", description: "Godness", brand: "Gucci", dateOfPurchase: .now, receipt: nil, imageName: "clothe4"),
        .init(id: 5, price: .init(amount: 100, currency: .pln), size: "L", category: Category(name: "Tops", subcategory: .init(name: "Bark")), color: .black, material: "Lace", description: "Nice one", brand: "Gucci", dateOfPurchase: .now, receipt: nil, imageName: "clothe5")
    ]
    
}

struct ClotheCategory: Hashable, Codable {
    var name: String
    var subcategories: [Subcategory]
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
