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
    @Published var selectedImageData: Data? = nil //UIImage(systemName: "photo.circle.fill")?.jpegData(compressionQuality: 1.0)!
    #warning("receipt should be optional")
    @Published var receiptImageData: Data? = UIImage(systemName: "camera")?.jpegData(compressionQuality: 1.0)!
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
        clotheDataProvider.saveClothe(subcategoryName: selectedCategory.subcategory?.name,
                                      categoryName: selectedCategory.name,
                                      localPrice: selectedPrice,
                                      receiptImageData: receiptImageData,
                                      clotheBrand: selectedBrand,
                                      clotheColor: selectedColor,
                                      clotheDateOfPurchase: selectedDate,
                                      clotheDescription: description,
                                      clotheImageData: selectedImageData,
                                      clotheMaterial: selectedMaterial,
                                      clotheSize: selectedSize,
                                      coreDataContext: context)
    }
}
