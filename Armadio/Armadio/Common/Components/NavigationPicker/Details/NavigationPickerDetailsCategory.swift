//
//  NavigationPickerDetailsCategory.swift
//  Armadio
//
//  Created by Bartłomiej on 04/11/2022.
//

import SwiftUI

struct NavigationPickerDetailsCategory: View {
    @Environment(\.dismiss) var dismiss
    @Binding var bindCategory: LocalCategory
    @State private var effectAppear = false
    @State private var isDisplayedCategory: Bool = false
    @State private var isDisplayedSubCategory: Bool = false
    private var categories = ClotheCategory.categoriesMock
    @State private var category: ClotheCategory = ClotheCategory.categoriesMock[0]
    @State private var  subcategory: LocalSubcategory = ClotheCategory.categoriesMock[0].subcategories[0]
    private let title: String = "Category"
    
    init(bindCategory: Binding<LocalCategory>) {
        self._bindCategory = bindCategory
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Category")
                                .font(.system(size: 12, weight: .light))
                            Text(category.name)
                        }
                        Spacer()
                        Image(systemName: "arrow.right")
                    }
                    .foregroundColor(Color.themeColor(.primaryText))
                    .padding()
                    .frame(height: 60)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(effectAppear ? .blue : .gray,
                                    lineWidth: 2)
                    )
                    .onTapGesture {
                        isDisplayedCategory.toggle()
                    }
                    .sheet(isPresented: $isDisplayedCategory) {
                        Picker("", selection: $category, content: {
                            ForEach(categories, id: \.self) {
                                Text($0.name)
                            }
                        })
                        .pickerStyle(.inline)
                        .presentationDetents([.fraction(0.3)])
                    }
                    
                    HStack {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Subcategory")
                                    .font(.system(size: 12, weight: .light))
                                Text(subcategory.name ?? "Empty name")
                                
                            }
                            Spacer()
                            Image(systemName: "arrow.right")
                        }
                        .foregroundColor(Color.themeColor(.primaryText))
                        .padding()
                        .frame(height: 60)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(effectAppear ? .blue : .gray,
                                        lineWidth: 2)
                        )
                        .onChange(of: category, perform: { category in
                            if !category.subcategories.contains(subcategory) {
                                subcategory = category.subcategories[0]
                            }
                        })
                        .onTapGesture {
                            isDisplayedSubCategory.toggle()
                        }
                        .sheet(isPresented: $isDisplayedSubCategory) {
                            Picker("", selection: $subcategory, content: {
                                ForEach(category.subcategories, id: \.self) {
                                    Text($0.name ?? "Empty name")
                                }
                            })
                            .pickerStyle(.inline)
                            .presentationDetents([.fraction(0.3)])
                        }
                    }
                    
                    
                    
                }.padding()
                
                Spacer()
                
                PrimaryButton(text: "Save") {
                    bindCategory = LocalCategory(name: category.name, subcategory: .init(name: subcategory.name))
                    dismiss()
                }
            }
            .navigationTitle(title)
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

struct NavigationPickerDetailsCategory_Previews: PreviewProvider {
    static var previews: some View {
        NavigationPickerDetailsCategory(bindCategory: .constant(.init(name: "Category1", subcategory: .init(name: "Subcategory1"))))
    }
}
