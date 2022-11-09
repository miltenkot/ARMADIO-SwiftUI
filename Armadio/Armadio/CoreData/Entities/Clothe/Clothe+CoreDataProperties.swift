//
//  Clothe+CoreDataProperties.swift
//  Armadio
//
//  Created by Bartłomiej on 11/11/2022.
//
//

import Foundation
import CoreData
import SwiftUI

extension Clothe {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Clothe> {
        return NSFetchRequest<Clothe>(entityName: "Clothe")
    }

    @NSManaged public var brand: String?
    @NSManaged public var dateOfPurchase: Date?
    @NSManaged public var desc: String?
    @NSManaged public var id: UUID?
    @NSManaged public var image: Data?
    @NSManaged public var material: String?
    @NSManaged public var size: String?
    @NSManaged public var price: Price?
    @NSManaged public var category: Category?
    @NSManaged public var receipt: Receipt?
    @NSManaged fileprivate var colorValue: String?
    var color: Color {
        get {
            switch colorValue {
            case "red":
                return .red
            case "orange":
                return .orange
            case "yellow":
                return .yellow
            case "green":
                return .green
            case "mint":
                return .mint
            case "teal":
                return .teal
            case "cyan":
                return .cyan
            case "blue":
                return .blue
            case "indigo":
                return .indigo
            case "purple":
                return .purple
            case "pink":
                return .pink
            case "brown":
                return .brown
            case "white":
                return .white
            case "gray":
                return .gray
            case "black":
                return .black
            default:
                return .red
            }
        }
        set {
            switch newValue {
            case .red:
                colorValue = "red"
            case .orange:
                colorValue = "orange"
            case .yellow:
                colorValue = "yellow"
            case .green:
                colorValue = "green"
            case .mint:
                colorValue = "mint"
            case .teal:
                colorValue = "teal"
            case .cyan:
                colorValue = "cyan"
            case .blue:
                colorValue = "blue"
            case .indigo:
                colorValue = "indigo"
            case .purple:
                colorValue = "purple"
            case .pink:
                colorValue = "pink"
            case .brown:
                colorValue = "brown"
            case .white:
                colorValue = "white"
            case .gray:
                colorValue = "gray"
            case .black:
                colorValue = "black"
            default:
                colorValue = "red"
            }
        }
    }

}

extension Clothe : Identifiable {

}
