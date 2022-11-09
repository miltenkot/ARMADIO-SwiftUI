//
//  PersistenceManager.swift
//  Armadio
//
//  Created by Bartłomiej on 08/11/2022.
//

import CoreData
import SwiftUI
import UIKit

class CoreDataStack: ObservableObject {
    let container: NSPersistentContainer
    
    init(inMemeory: Bool = false) {
        container = NSPersistentContainer(name: "Armadio")
        
        if inMemeory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("loadPersistentStores error: \(error)")
            }
        }
    }
}

// MARK: - Clothe core data provider

extension CoreDataStack {
    func saveClothe(subcategoryName: String,
                    categoryName: String,
                    receiptImageData: Data,
                    clotheBrand: String, clotheColor: Color, clotheDateOfPurchase: Date, clotheDescription: String,
                    clotheImageData: Data, clotheMaterial: String, clotheSize: String) {
        let subcategory = Subcategory(context: container.viewContext)
        subcategory.name = subcategoryName
        let category = Category(context: container.viewContext)
        category.name = categoryName
        category.subcategory = subcategory
        let receipt = Receipt(context: container.viewContext)
        receipt.image = receiptImageData
        let clothe = Clothe(context: container.viewContext)
        clothe.id = UUID()
        clothe.brand = clotheBrand
        clothe.color = clotheColor
        clothe.dateOfPurchase = clotheDateOfPurchase
        clothe.desc = clotheDescription
        clothe.image = clotheImageData
        clothe.material = clotheMaterial
        clothe.size = clotheSize
        clothe.category = category
        clothe.receipt = receipt
        
        do {
            try container.viewContext.save()
        } catch {
            print("save clothe failed \(error)")
        }
    }
}

extension CoreDataStack {
    static var preview: CoreDataStack = {
      let coreDataStack = CoreDataStack(inMemeory: true)
        coreDataStack.saveClothe(subcategoryName: "Subcategory 1", categoryName: "Category 1", receiptImageData: (UIImage(named: "receipt1")?.jpegData(compressionQuality: 0.8))!, clotheBrand: "Gucci", clotheColor: .red, clotheDateOfPurchase: .now, clotheDescription: "Lorem ipsum", clotheImageData: (UIImage(named: "clothe1")?.jpegData(compressionQuality: 0.8))!, clotheMaterial: "Cotton", clotheSize: "XXL")
        
        coreDataStack.saveClothe(subcategoryName: "Subcategory 2", categoryName: "Category 1", receiptImageData: (UIImage(named: "receipt2")?.jpegData(compressionQuality: 0.8))!, clotheBrand: "Luis", clotheColor: .red, clotheDateOfPurchase: .now, clotheDescription: "Lorem ipsum", clotheImageData: (UIImage(named: "clothe2")?.jpegData(compressionQuality: 0.8))!, clotheMaterial: "Cotton", clotheSize: "XXL")
        
        coreDataStack.saveClothe(subcategoryName: "Subcategory 3", categoryName: "Category 2", receiptImageData: (UIImage(named: "receipt3")?.jpegData(compressionQuality: 0.8))!, clotheBrand: "Michael", clotheColor: .red, clotheDateOfPurchase: .now, clotheDescription: "Lorem ipsum", clotheImageData: (UIImage(named: "clothe3")?.jpegData(compressionQuality: 0.8))!, clotheMaterial: "Cotton", clotheSize: "XXL")
        
        do {
            try coreDataStack.container.viewContext.save()
        } catch {
            fatalError("loadPersistentStores error: \(error)")
        }
      return coreDataStack
    }()
}
