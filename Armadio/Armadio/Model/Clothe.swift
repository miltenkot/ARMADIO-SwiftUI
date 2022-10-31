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
    
    enum Category: String, CaseIterable, Codable {
        case bottoms = "bottoms"
        case dresses = "dresses"
        case outewear = "outewear"
        case shoes = "shoes"
        case tops = "tops"
        case accessories = "accessories"
    }
}

struct Price: Hashable, Codable {
    var amount: Double
    var currency: Currency
}

enum Currency: String, Codable {
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
        .init(id: 1, price: .init(amount: 300, currency: .pln), size: "M", category: .bottoms, color: .red, material: "Chiffon", description: "Nice clothe", brand: "Gucci", dateOfPurchase: .now, receipt: nil, imageName: "clothe1"),
        .init(id: 2, price: .init(amount: 500, currency: .eur), size: "L", category: .accessories, color: .yellow, material: "Cotton", description: "Elegance", brand: "Gucci", dateOfPurchase: .now, receipt: nil, imageName: "clothe2"),
        .init(id: 3, price: .init(amount: 1000, currency: .eur), size: "XXL", category: .accessories, color: .blue, material: "Crepe", description: "OMG Awesome", brand: "Gucci", dateOfPurchase: .now, receipt: nil, imageName: "clothe3"),
        .init(id: 4, price: .init(amount: 600, currency: .pln), size: "S", category: .dresses, color: .black, material: "Denim", description: "Godness", brand: "Gucci", dateOfPurchase: .now, receipt: nil, imageName: "clothe4"),
        .init(id: 5, price: .init(amount: 100, currency: .pln), size: "L", category: .tops, color: .black, material: "Lace", description: "Nice one", brand: "Gucci", dateOfPurchase: .now, receipt: nil, imageName: "clothe5")
    ]
}
