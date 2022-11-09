//
//  AddNewClotheView.swift
//  Armadio
//
//  Created by Bartłomiej on 01/11/2022.
//

import SwiftUI

enum Route: Hashable {
    case price
    case receipt
    case category
    case color
    case size
    case brand
    case dateOfPurchase
    case description
    case material
}

struct AddNewClotheView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var moc
    @StateObject var viewModel = AddNewClotheViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                Group {
                    PhotosPickerView(selectedItem: $viewModel.selectedItem, selectedImageData: $viewModel.selectedImageData).padding(.horizontal)
                    
                    NavigationLink(value: Route.price) {
                        NavigationPickerLabel(title: "Price", content: priceLabel)
                    }
                    
                    NavigationLink(value: Route.receipt) {
                        NavigationPickerLabel(title: "Receipt", content: scanLabel)
                    }
                    
                    NavigationLink(value: Route.category) {
                        NavigationPickerLabel(title: "Category", content: categoryLabel)
                    }
                }
                
                Group {
                    NavigationLink(value: Route.color) {
                        NavigationPickerLabel(title: "Color", content: colorLabel)
                    }
                    
                    NavigationLink(value: Route.size) {
                        NavigationPickerLabel(title: "Size", content: sizeLabel)
                    }
                    
                    NavigationLink(value: Route.brand) {
                        NavigationPickerLabel(title: "Brand", content: brandLabel)
                    }
                    
                    NavigationLink(value: Route.material) {
                        NavigationPickerLabel(title: "Material", content: materialLabel)
                    }
                    
                    NavigationLink(value: Route.dateOfPurchase) {
                        NavigationPickerLabel(title: "Date Of Purchase", content: dateOfPurchaseLabel)
                    }
                    
                    NavigationLink(value: Route.description) {
                        NavigationPickerLabel(title: "Description", content: descriptionLabel)
                    }
                }
                
                PrimaryButton(text: "Save", foregroundColor: .themeColor(.primaryButtonFColor), backgroundColor: .themeColor(.primaryButtonBColor)) {
                    viewModel.saveClothe(for: moc)
                    viewModel.logEvent("\(viewModel.selectedPrice.amount)")
                    dismiss()
                }.padding(.horizontal)
            }
            .navigationDestination(for: Route.self, destination: { route in
                Group {
                    switch route {
                    case .price:
                        NavigationPickerDetailsPrice(price: $viewModel.selectedPrice)
                    case .receipt:
                        ScannerDetailsView(isRecognizing: $viewModel.isReceiptRecognizing, receiptImageData: $viewModel.receiptImageData)
                    case .category:
                        NavigationPickerDetailsCategory(bindCategory: $viewModel.selectedCategory)
                    case .color:
                        ColorPickerDetails(selection: $viewModel.selectedColor)
                    case .size:
                        NavigationPickerDetailsDefault(title: "Size",
                                                       items: viewModel.sizes, item: $viewModel.selectedSize)
                    case .brand:
                        NavigationPickerDetailsDefault(title: "Brand",
                                                       items: viewModel.brands,
                                                       item: $viewModel.selectedBrand)
                    case .material:
                        NavigationPickerDetailsDefault(title: "Material",
                                                       items: viewModel.material,
                                                       item: $viewModel.selectedMaterial)
                    case .dateOfPurchase:
                        NavigationPickerDetailsDate(date: $viewModel.selectedDate)
                    case .description:
                        NavigationPickerDetailsDescription(title: "Description", text: $viewModel.description)
                    }
                }
                .navigationBarBackButtonHidden(true)
                
            })
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationButton(type: .back) {
                        dismiss()
                    }
                }
            }
        }
    }
}

// MARK: - Labels

extension AddNewClotheView {
    @ViewBuilder private var priceLabel: some View {
        Text("\(viewModel.selectedPrice.amount, specifier: "%.2f")  \(viewModel.selectedPrice.currency.rawValue.uppercased())")
    }
    
    @ViewBuilder private var scanLabel: some View {
        HStack {
            Image(systemName: "doc.text.viewfinder")
                .foregroundColor(viewModel.isReceiptRecognizing ? .green : .themeColor(.primaryText))
            Text(viewModel.isReceiptRecognizing ? "Saved" : "Empty")
        }
    }
    
    @ViewBuilder private var categoryLabel: some View {
        Text("\(viewModel.selectedCategory.name) / \(viewModel.selectedCategory.subcategory.name)")
    }
    
    @ViewBuilder private var colorLabel: some View {
        Text(viewModel.selectedColor.description)
            .padding(.horizontal, 25)
            .padding(.vertical, 4)
            .foregroundColor(Color.themeColor(.primaryText))
            .background(viewModel.selectedColor)
            .cornerRadius(4)
    }
    
    @ViewBuilder private var sizeLabel: some View {
        Text("\(viewModel.selectedSize)")
    }
    
    @ViewBuilder private var brandLabel: some View {
        Text("\(viewModel.selectedBrand)")
    }
    
    @ViewBuilder private var materialLabel: some View {
        Text("\(viewModel.selectedMaterial)")
    }
    
    @ViewBuilder private var dateOfPurchaseLabel: some View {
        Text("\(viewModel.selectedDate.formatted(.dateTime.day().month().year()))")
    }
    
    @ViewBuilder private var descriptionLabel: some View {
        Text("\(viewModel.description)")
    }
}

struct AddNewClotheView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewClotheView()
    }
}
