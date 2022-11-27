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
        self.price?.amount = object.price?.amount ?? 0
        self.price?.currency = object.price?.currency ?? .pln
        self.category?.name = object.category?.name
        self.category?.subcategory?.name = object.category?.subcategory?.name
        self.receipt?.image = object.receipt?.image
        self.color = object.color
    }
}

extension LocalClothe {
    static private(set) var brandMock: [String] = ["Gucci", "Luis", "Micheal Kors", "Armani", "TOmmy", "Adidas", "Nike"]
    static private(set) var sizesMock: [String] = ["XSS", "XS", "S", "M", "L", "XL", "XLL"]
    static private(set) var materialMock: [String] = ["Coton", "Whool", "Gold", "Silver", "Many", "Sos", "Ross"]
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
    static var categoriesMock: [ClotheCategory] = [.init(name: "T-shirty i koszulki polo",
                                                         subcategories: [
                                                            .init(name: "T-shirty basic"),
                                                            .init(name: "T-shirty z nadrukiem"),
                                                            .init(name: "Tank top"),
                                                            .init(name: "Koszulki polo"),
                                                            .init(name: "Bluzki z długim rękawem"),
                                                            .init(name: "T-shirty sportowe")
                                                         ]),
                                                   .init(name: "Koszule",
                                                         subcategories: [
                                                            .init(name: "Koszule na co dzień"),
                                                            .init(name: "Koszule biznesowe")
                                                         ]),
                                                   .init(name: "Swetry i bluzy",
                                                         subcategories: [
                                                            .init(name: "Bluzy z kapturem"),
                                                            .init(name: "Bluzy nierozpinane"),
                                                            .init(name: "Bluzy rozpinane"),
                                                            .init(name: "Bluzy polarowe")
                                                         ]),
                                                   .init(name: "Jeansy",
                                                         subcategories: [
                                                            .init(name: "Skinny fit"),
                                                            .init(name: "Slim fit"),
                                                            .init(name: "Straight leg"),
                                                            .init(name: "Zwężane jeansy"),
                                                            .init(name: "Relaxed & loose fit"),
                                                            .init(name: "Bootcut"),
                                                            .init(name: "Szorty jeansowe")
                                                         ]),
                                                   .init(name: "Spodnie",
                                                         subcategories: [
                                                            .init(name: "Chinosy"),
                                                            .init(name: "Eleganckie spodnie"),
                                                            .init(name: "Bojówki"),
                                                            .init(name: "Spodnie treningowe"),
                                                            .init(name: "Ogrodniczki")
                                                         ]),
                                                   .init(name: "Szorty",
                                                         subcategories: [
                                                            .init(name: "Codzienne szorty"),
                                                            .init(name: "Szorty dżinsowe"),
                                                            .init(name: "Szorty sportowe")
                                                         ]),
                                                   .init(name: "Sukienki",
                                                         subcategories: [
                                                            .init(name: "Sukienki letnie"),
                                                            .init(name: "Sukienki koktajlowe"),
                                                            .init(name: "Sukienki wieczorowe"),
                                                            .init(name: "Sukienki koszulowe"),
                                                            .init(name: "Sukienki z dżerseju"),
                                                            .init(name: "Sukienki etui"),
                                                            .init(name: "Sukienki maxi")
                                                         ])]
}
