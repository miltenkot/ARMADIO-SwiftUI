//
//  CountryPickerView.swift
//  Armadio
//
//  Created by Bartłomiej on 30/11/2022.
//

import SwiftUI

/// List contains names and flags of available in application countries.
struct CountryPickerView: View {
    
    @StateObject var viewModel = CountryPickerViewModel()
    @Binding var countryCode: String?
    
    var body: some View {
        Button {
            viewModel.isDisplayed.toggle()
        } label: {
            HStack {
                VStack(alignment: .leading) {
                    Text("SelectYourCountryView_Armadio".localized)
                        .font(.system(size: 12, weight: .light))
                    HStack {
                        Text(viewModel.getCountryFlag(countryCode: countryCode))
                        Text(viewModel.getCountryName(countryCode: countryCode))
                            .textStyle(NormalStyle())
                        
                    }
                }
                
                Spacer()
                Image(systemName: "arrow.right")
            }
            .foregroundColor(Color.themeColor(.primaryText))
            .padding()
        }
        .frame(height: 60)
        .foregroundColor(.white)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(.gray, lineWidth: 2)
        )
        .padding()
        .sheet(isPresented: $viewModel.isDisplayed) {
            CountryListView(selectedFlag: $countryCode)
                .presentationDetents([.large])
                .presentationDragIndicator(.visible)
            
        }
    }
}

struct CountryPickerView_Previews: PreviewProvider {
    static var previews: some View {
        CountryPickerView(countryCode: .constant("AC"))
    }
}
