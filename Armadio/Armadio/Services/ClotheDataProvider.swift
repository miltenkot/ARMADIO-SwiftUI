//
//  ClotheDataProvider.swift
//  Armadio
//
//  Created by Bartłomiej on 14/11/2022.
//

import Foundation
import CoreData
import SwiftUI

protocol ClotheDataProvider {
    func updateClotheStats(clothe: Clothe, coreDataContext: NSManagedObjectContext)
    func saveClothe(subcategoryName: String?,
                    categoryName: String?,
                    localPrice: LocalPrice?,
                    receiptImageData: Data?,
                    clotheBrand: String?, clotheColor: Color, clotheDateOfPurchase: Date?, clotheDescription: String?,
                    clotheImageData: Data?, clotheMaterial: String?, clotheSize: String?, coreDataContext: NSManagedObjectContext)
}

final class ClotheDataProviderImpl: ClotheDataProvider {
    
    func updateClotheStats(clothe: Clothe, coreDataContext: NSManagedObjectContext) {
        clothe.stats?.numberOfWorn += 1
        clothe.stats?.recentlyWornDate = .now
        do {
            try coreDataContext.save()
        } catch {
            print("update clothe failed \(error)")
        }
    }
    
    func saveClothe(subcategoryName: String?,
                    categoryName: String?,
                    localPrice: LocalPrice?,
                    receiptImageData: Data?,
                    clotheBrand: String?, clotheColor: Color, clotheDateOfPurchase: Date?, clotheDescription: String?,
                    clotheImageData: Data?, clotheMaterial: String?, clotheSize: String?,
                    coreDataContext: NSManagedObjectContext) {
        let subcategory = Subcategory(context: coreDataContext)
        subcategory.name = subcategoryName
        let category = Category(context: coreDataContext)
        category.name = categoryName
        category.subcategory = subcategory
        let receipt = Receipt(context: coreDataContext)
        receipt.image = receiptImageData
        let clothe = Clothe(context: coreDataContext)
        clothe.id = UUID()
        clothe.brand = clotheBrand
        clothe.color = clotheColor
        clothe.dateOfPurchase = clotheDateOfPurchase
        clothe.desc = clotheDescription
        clothe.image = clotheImageData
        clothe.material = clotheMaterial
        clothe.size = clotheSize
        let price = Price(context: coreDataContext)
        price.amount = localPrice?.amount ?? 0
        price.currency = localPrice?.currency ?? .pln
        clothe.price = price
        let stats = Stats(context: coreDataContext)
        stats.numberOfWorn = 0
        stats.recentlyWornDate = .now
        clothe.stats = stats
        clothe.category = category
        clothe.receipt = receipt
        
        do {
            try coreDataContext.save()
        } catch {
            print("save clothe failed \(error)")
        }
    }
    
}
