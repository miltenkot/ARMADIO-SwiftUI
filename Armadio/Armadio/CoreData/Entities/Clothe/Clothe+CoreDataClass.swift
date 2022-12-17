//
//  Clothe+CoreDataClass.swift
//  Armadio
//
//  Created by Bartłomiej on 11/11/2022.
//
//

import Foundation
import CoreData
import UIKit

/// A class conforming to `NSManagedObject` represents clothe.
@objc(Clothe)
public class Clothe: NSManagedObject {
    
}

extension Clothe {
    static var mock: Clothe = {
        let context = CoreDataStack.preview.container.viewContext
        let item = Clothe(context: context)
        item.id = UUID()
        item.desc = "Nice clothe bro! I have lot of days when i was a child"
        item.image = (UIImage(named: "open_wardrobe")?.jpegData(compressionQuality: 1.0))!
        item.material = "Cotton"
        item.size = "XXL"
        let price = Price(context: context)
        price.currency = .pln
        price.amount = 400.00
        item.price = price
        let category = Category(context: context)
        category.name = "Bottoms"
        let subcategory = Subcategory(context: context)
        subcategory.name = "Sweet"
        category.subcategory = subcategory
        item.category = category
        item.brand = "Gucci"
        item.dateOfPurchase = .now
        item.color = .red
        let receipt = Receipt(context: context)
        receipt.image = UIImage(named: "receipt1")?.jpegData(compressionQuality: 1.0)
        item.receipt = receipt
        return item
    }()
}
