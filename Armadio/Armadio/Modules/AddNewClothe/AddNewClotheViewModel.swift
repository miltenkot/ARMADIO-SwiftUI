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
    @Published var selectedCategory: LocalCategory = .init(name: ClotheCategory.categoriesMock.first?.name ?? "Empty",
                                                           subcategory: .init(name: ClotheCategory.categoriesMock.first?.subcategories.first?.name ?? "Empty"))
    @Published var selectedBrand: String = LocalClothe.brandMock.first!
    @Published var selectedMaterial: String = LocalClothe.materialMock.first!
    @Published var selectedPrice: LocalPrice = .init(amount: 0.0, currency: .pln)
    @Published var selectedItem: PhotosPickerItem? = nil
    @Published var selectedDate = Date()
    @Published var selectedColor: Color = .brown
    @Published var description = ""
    @Published var selectedSize = LocalClothe.sizesMock.first!
    @Published var isReceiptRecognizing = false
    
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
