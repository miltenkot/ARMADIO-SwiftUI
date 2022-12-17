//
//  ClotheDataProvider.swift
//  Armadio
//
//  Created by Bartłomiej on 14/11/2022.
//

import Foundation
import CoreData
import SwiftUI

/// Methods that provide core data clothes functionality.
protocol ClotheDataProvider {
    func updateClotheStats(clothe: Clothe, coreDataContext: NSManagedObjectContext)
    func saveClothe(subcategoryName: String?,
                    categoryName: String?,
                    localPrice: LocalPrice?,
                    receiptImageData: Data?,
                    clotheBrand: String?, clotheColor: Color, clotheDateOfPurchase: Date?, clotheDescription: String?,
                    clotheImageData: Data?, clotheMaterial: String?, clotheSize: String?, coreDataContext: NSManagedObjectContext)
}

/// A class conforming to `ClotheDataProvider` used to work with clothes persistance using core data.
final class ClotheDataProviderImpl: ClotheDataProvider {
    
    /// Update `numberOfWorn` parameter adding `1`(number of uses) to it and `recentlyWornDate` to `.now`.
    /// - Parameters:
    ///   - clothe: NSManagedObject `Clothe` we want to update
    ///   - coreDataContext: NSManagedObjectContext our `Clothe`
    func updateClotheStats(clothe: Clothe, coreDataContext: NSManagedObjectContext) {
        clothe.stats?.numberOfWorn += 1
        clothe.stats?.recentlyWornDate = .now
        do {
            try coreDataContext.save()
        } catch {
            print("update clothe failed \(error)")
        }
    }
    
    /// Save `Clothe` object with specific parameters.
    /// - Parameters:
    ///   - subcategoryName: optional subcategory string
    ///   - categoryName: optional category string
    ///   - localPrice: optional `LocalPrice` contains amount and currency
    ///   - receiptImageData: optional data of receipt image
    ///   - clotheBrand: optional brand string
    ///   - clotheColor: optional color string
    ///   - clotheDateOfPurchase: optional data of purchase string
    ///   - clotheDescription: optional description string
    ///   - clotheImageData: optional data of clothe image
    ///   - clotheMaterial:  optional material string
    ///   - clotheSize:  optional size string
    ///   - coreDataContext: NSManagedObjectContext our `Clothe`
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
