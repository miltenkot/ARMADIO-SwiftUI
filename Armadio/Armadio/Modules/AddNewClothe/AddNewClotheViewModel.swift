//
//  AddNewClotheViewModel.swift
//  Armadio
//
//  Created by Bartłomiej on 02/11/2022.
//

import SwiftUI
import PhotosUI

final class AddNewClotheViewModel: ObservableObject {
    @Published var selectedImageData: Data? = nil
    @Published var selectedCategory: Category = .init(name: "Dresses", subcategory: .init(name: "Short"))
    @Published var selectedBrand: String = "Gucci"
    @Published var selectedPrice: Price = .init(amount: 0.0, currency: .pln)
    @Published var selectedItem: PhotosPickerItem? = nil
    @Published var selectedDate = Date()
    @Published var selectedColor: Color = .red
    @Published var description = ""
    @Published var selectedSize = "XS"
    let sizes: [String] = ["XSS", "XS", "S", "M", "L", "XL", "XLL"]
    let brands: [String] = ["Gucci", "Luis", "Micheal Kors", "Armani", "TOmmy", "Adidas", "Nike"]
    
}
