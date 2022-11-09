//
//  Price+CoreDataProperties.swift
//  Armadio
//
//  Created by Bartłomiej on 11/11/2022.
//
//

import Foundation
import CoreData


extension Price {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Price> {
        return NSFetchRequest<Price>(entityName: "Price")
    }

    @NSManaged public var amount: Double
    @NSManaged fileprivate var currencyValue: String?
    var currency: Currency {
        get {
            return Currency(rawValue: currencyValue ?? "pln") ?? .pln
        }
        set {
            currencyValue = newValue.rawValue
        }
    }

}

extension Price : Identifiable {

}
