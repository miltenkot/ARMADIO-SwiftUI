//
//  Stats+CoreDataProperties.swift
//  Armadio
//
//  Created by Bartłomiej on 22/11/2022.
//
//

import Foundation
import CoreData


extension Stats {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Stats> {
        return NSFetchRequest<Stats>(entityName: "Stats")
    }

    @NSManaged public var recentlyWornDate: Date
    @NSManaged public var numberOfWorn: Int32
    @NSManaged public var clothe: Clothe?

}

extension Stats : Identifiable {

}
