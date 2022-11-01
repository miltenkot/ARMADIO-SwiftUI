//
//  NavigationPickerDetailsDefault.swift
//  Armadio
//
//  Created by Bartłomiej on 05/11/2022.
//

import SwiftUI

struct NavigationPickerDetailsDefault: View {
    @Environment(\.dismiss) var dismiss
    @State private var effectAppear = false
    @State private var isDisplayed: Bool = false
    @State private var selectedSize: String = ""
    @Binding var bindingItem: String
    private let title: String
    let items: [String]
    
    init(title: String, items: [String], item: Binding<String>) {
        self.title = title
        self.items = items
        self._bindingItem = item
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Select your " + title.lowercased())
                                .font(.system(size: 12, weight: .light))
                            Text(selectedSize.isEmpty ? (!items.isEmpty ? items[0] : "") : selectedSize)
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
                        isDisplayed.toggle()
                    }
                    .sheet(isPresented: $isDisplayed) {
                        Picker("", selection: $selectedSize, content: {
                            ForEach(items, id: \.self) {
                                Text($0)
                            }
                        })
                        .pickerStyle(.inline)
                        .presentationDetents([.fraction(0.35)])
                    }
                }.padding()
                
                Spacer()
                PrimaryButton(text: "Save") {
                    bindingItem = selectedSize
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
        .onAppear {
            selectedSize = bindingItem
        }
    }
}


struct NavigationPickerDetailsDefault_Previews: PreviewProvider {
    static var previews: some View {
        NavigationPickerDetailsDefault(title: "Size",
                                       items: ["Default"],
                                       item: .constant("M"))
    }
}
