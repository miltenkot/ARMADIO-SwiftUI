//
//  AddNewClotheView.swift
//  Armadio
//
//  Created by Bartłomiej on 01/11/2022.
//

import SwiftUI

/// Route enum represents add new clothe list elements.
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

/// View represents a list of labels that navigate to the appropriate views where we can change ``Clothe`` properies we want to save.
struct AddNewClotheView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var context
    @StateObject var viewModel = AddNewClotheViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                Group {
                    PhotosPickerView(selectedItem: $viewModel.selectedItem, selectedImageData: $viewModel.selectedImageData)
                        .padding(.horizontal)
                    
                    NavigationLink(value: Route.price) {
                        NavigationPickerLabel(title: "AddNewClotheView_Price".localized, content: priceLabel)
                    }
                    
                    NavigationLink(value: Route.receipt) {
                        NavigationPickerLabel(title: "AddNewClotheView_Receipt".localized, content: scanLabel)
                    }
                    
                    NavigationLink(value: Route.category) {
                        NavigationPickerLabel(title: "AddNewClotheView_Category".localized, content: categoryLabel)
                    }
                }
                
                Group {
                    NavigationLink(value: Route.color) {
                        NavigationPickerLabel(title: "AddNewClotheView_Color".localized, content: colorLabel)
                    }
                    
                    NavigationLink(value: Route.size) {
                        NavigationPickerLabel(title: "AddNewClotheView_Size".localized, content: sizeLabel)
                    }
                    
                    NavigationLink(value: Route.brand) {
                        NavigationPickerLabel(title: "AddNewClotheView_Brand".localized, content: brandLabel)
                    }
                    
                    NavigationLink(value: Route.material) {
                        NavigationPickerLabel(title: "AddNewClotheView_Material".localized, content: materialLabel)
                    }
                    
                    NavigationLink(value: Route.dateOfPurchase) {
                        NavigationPickerLabel(title: "AddNewClotheView_DateOfPurchase".localized, content: dateOfPurchaseLabel)
                    }
                    
                    NavigationLink(value: Route.description) {
                        NavigationPickerLabel(title: "AddNewClotheView_Description".localized, content: descriptionLabel)
                    }
                }
                
                PrimaryButton(text: "AddNewClotheView_Save".localized, foregroundColor: .themeColor(.primaryButtonFColor), backgroundColor: .themeColor(.primaryColor)) {
                    viewModel.saveClothe(for: context)
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
                        #if targetEnvironment(simulator)
                        SimulatorDefaulView()
                        #else
                        ScannerDetailsView(isRecognizing: $viewModel.isReceiptRecognizing, receiptImageData: $viewModel.receiptImageData)
                        #endif
                    case .category:
                        NavigationPickerDetailsCategory(bindCategory: $viewModel.selectedCategory)
                    case .color:
                        ColorPickerDetails(selection: $viewModel.selectedColor)
                    case .size:
                        NavigationPickerDetailsDefault(title: "Size",
                                                       items: LocalClothe.sizesMock, item: $viewModel.selectedSize)
                    case .brand:
                        NavigationPickerDetailsDefault(title: "Brand",
                                                       items: LocalClothe.brandMock,
                                                       item: $viewModel.selectedBrand)
                    case .material:
                        NavigationPickerDetailsDefault(title: "Material",
                                                       items: LocalClothe.materialMock,
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
        Text("\(viewModel.selectedCategory.name ?? "empty name") / \(viewModel.selectedCategory.subcategory?.name ?? "empty subcategory name")")
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
