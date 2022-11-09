//
//  Receipt+CoreDataProperties.swift
//  Armadio
//
//  Created by Bartłomiej on 11/11/2022.
//
//

import Foundation
import CoreData


extension Receipt {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Receipt> {
        return NSFetchRequest<Receipt>(entityName: "Receipt")
    }

    @NSManaged public var image: Data?
    @NSManaged public var clothe: Clothe?

}

extension Receipt : Identifiable {

}
