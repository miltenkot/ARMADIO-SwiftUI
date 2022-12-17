//
//  LocalClothe.swift
//  Armadio
//
//  Created by Bartłomiej on 29/10/2022.
//

import Foundation
import SwiftUI

/// A class used to local non core data clothe used e.g `AppStorage` objects.
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
    
    /// `LocalClothe` initializer which set all properties
    /// - Parameters:
    ///   - brand: default nil brand of clothe
    ///   - dateOfPurchase: default nil date of purchase
    ///   - desc: default nil description of clothe
    ///   - id: default nil id of clothe
    ///   - image: default nil data of clothe image
    ///   - material: default nil clothe material
    ///   - size: default nil clothe size
    ///   - price: default nil `LocalPrice` of clothe that constains amount and currency
    ///   - category: default nil `LocalCategory` of clothe thath contains name and subcategory
    ///   - receipt: default nil data of receipt image
    ///   - color: default nil color of clothe
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
    
    /// `LocalClothe` initializer which map all properties from NSManagedObject `Clothe`
    /// - Parameter object: represent clothe in core data as NSManagedObject
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
    static private(set) var brandMock: [String] = ["Unknown", "Gucci", "Luis", "Micheal Kors", "Armani", "TOmmy", "Adidas", "Nike"]
    static private(set) var sizesMock: [String] = ["XSS", "XS", "S", "M", "L", "XL", "XLL"]
    static private(set) var materialMock: [String] = ["Unknown", "Coton", "Whool", "Gold", "Silver", "Many", "Sos", "Ross"]
}

/// A struct conforming to `Hashable` and `Codable` represents clothe category.
struct LocalCategory: Hashable, Codable {
    var name: String?
    var subcategory: LocalSubcategory?
}

/// A struct conforming to `Hashable` and `Codable` represents clothe subcategory.
struct LocalSubcategory: Hashable, Codable {
    var name: String?
}

/// A struct conforming to `Hashable` and `Codable` represents clothe price.
struct LocalPrice: Hashable, Codable {
    var amount: Double
    var currency: Currency
}

/// A struct conforming to `Hashable` and `Codable` represents data of clothe receipt.
struct LocalReceipt: Hashable, Codable {
    var image: Data?
}

/// A enum conforming to `String`, `CaseIterable` and `Codable` represents available currencies in app.
enum Currency: String, Codable, CaseIterable {
    case eur
    case usd
    case sek
    case pln
}

extension LocalPrice: CustomStringConvertible {
    /// formated price description that constain 2 digits after `.` and currency code e.g `12.56 PLN`
    var description: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = currency.rawValue
        formatter.maximumFractionDigits = 2
        
        let number = NSNumber(value: amount)
        return formatter.string(from: number) ?? "None"
    }
}
/// A struct conforming to `Hashable` and `Codable` represents clothe categories used in lists.
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
