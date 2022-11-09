//
//  AddNewClotheViewModel.swift
//  Armadio
//
//  Created by Bartłomiej on 02/11/2022.
//

import SwiftUI
import PhotosUI
import Factory
import CoreData

final class AddNewClotheViewModel: ObservableObject {
    // MARK: - Injected
    
    @Injected(Container.firebaseAnaliticsProvider) private var firebaseAnaliticsProvider
    @Injected(Container.clotheDataProvider) private var clotheDataProvider
    
    // MARK: - Properties
    @Published var selectedImageData: Data? = nil
    @Published var receiptImageData: Data? = nil
    @Published var selectedCategory: LocalCategory = .init(name: "Dresses", subcategory: .init(name: "Short"))
    @Published var selectedBrand: String = "Gucci"
    @Published var selectedMaterial: String = "Coton"
    @Published var selectedPrice: LocalPrice = .init(amount: 0.0, currency: .pln)
    @Published var selectedItem: PhotosPickerItem? = nil
    @Published var selectedDate = Date()
    @Published var selectedColor: Color = .red
    @Published var description = ""
    @Published var selectedSize = "XS"
    @Published var isReceiptRecognizing = false
    let sizes: [String] = ["XSS", "XS", "S", "M", "L", "XL", "XLL"]
    let brands: [String] = ["Gucci", "Luis", "Micheal Kors", "Armani", "TOmmy", "Adidas", "Nike"]
    let material: [String] = ["Coton", "Whool", "Gold", "Silver", "Many", "Sos", "Ross"]
    
    // MARK: - FirebaseAnalitics
    
    func logEvent(_ string: String) {
        firebaseAnaliticsProvider.logSaveAction(amount: string)
    }
    
    // MARK: - Clothe DataProvider
    
    func saveClothe(for context: NSManagedObjectContext) {
        let subcategory = Subcategory(context: context)
        subcategory.name = selectedCategory.subcategory.name
        let category = Category(context: context)
        category.name = selectedCategory.name
        category.subcategory = subcategory
        let receipt = Receipt(context: context)
        receipt.image = UIImage(named: "receipt1")?.jpegData(compressionQuality: 0.8)
        let clothe = Clothe(context: context)
        clothe.id = UUID()
        clothe.brand = selectedBrand
        clothe.color = selectedColor
        clothe.dateOfPurchase = selectedDate
        clothe.desc = description
        clothe.image = selectedImageData
        clothe.material = selectedMaterial
        clothe.size = selectedSize
        clothe.category = category
        clothe.receipt = receipt
        
        do {
            if context.hasChanges {
                try context.save()
            }
        } catch {
            print("save failed \(error)")
        }
    }
}
