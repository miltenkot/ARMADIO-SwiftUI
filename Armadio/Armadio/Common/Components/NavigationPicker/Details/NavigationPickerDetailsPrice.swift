//
//  NavigationPickerDetailsPrice.swift
//  Armadio
//
//  Created by Bartłomiej on 04/11/2022.
//

import SwiftUI

struct NavigationPickerDetailsPrice: View {
    @Environment(\.dismiss) var dismiss
    @Binding var bindingPrice: Price
    @State private var price: Price = .init(amount: 0.0, currency: .pln)
    @State private var effectAppear = false
    @State private var isDisplayed: Bool = false
    private let title: String = "Price"
    
    private let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.generatesDecimalNumbers = true
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    init(price: Binding<Price>) {
        self._bindingPrice = price
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Currency".localized)
                                .font(.system(size: 12, weight: .light))
                            Text(price.currency.rawValue.uppercased())
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
                        Picker("", selection: $price.currency, content: {
                            ForEach(Currency.allCases, id: \.self) {
                                Text($0.rawValue.uppercased())
                            }
                        })
                        .pickerStyle(.inline)
                        .presentationDetents([.fraction(0.15)])
                    }
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Amount")
                                .font(.system(size: 12, weight: .light))
                            TextField("", value: $price.amount, formatter: formatter)
                                .keyboardType(.decimalPad)
                                .disableAutocorrection(true)
                                .onTapGesture {
                                    effectAppear = true
                                }
                        }
                    }
                    .foregroundColor(Color.themeColor(.primaryText))
                    .padding()
                    .frame(height: 60)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(effectAppear ? .blue : .gray,
                                    lineWidth: 2)
                    )
                    
                }.padding()
                
                Spacer()
                
                PrimaryButton(text: "Save") {
                    bindingPrice = price
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
            price = bindingPrice
        }
    }
}

struct NavigationPickerDetailsPrice_Previews: PreviewProvider {
    static var previews: some View {
        NavigationPickerDetailsPrice(price: .constant(.init(amount: 300.013, currency: .eur)))
    }
}
