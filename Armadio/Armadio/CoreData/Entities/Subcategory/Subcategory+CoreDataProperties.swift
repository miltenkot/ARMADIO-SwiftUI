//
//  Subcategory+CoreDataProperties.swift
//  Armadio
//
//  Created by Bartłomiej on 11/11/2022.
//
//

import Foundation
import CoreData


extension Subcategory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Subcategory> {
        return NSFetchRequest<Subcategory>(entityName: "Subcategory")
    }

    @NSManaged public var name: String?
    @NSManaged public var category: Category?

}

extension Subcategory : Identifiable {

}
