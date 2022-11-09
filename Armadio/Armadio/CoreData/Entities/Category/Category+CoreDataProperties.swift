//
//  Category+CoreDataProperties.swift
//  Armadio
//
//  Created by Bartłomiej on 11/11/2022.
//
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var name: String?
    @NSManaged public var subcategory: Subcategory?
    @NSManaged public var clothe: Clothe?

}

extension Category : Identifiable {

}
