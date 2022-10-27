//
//  CountryListView.swift
//  Armadio
//
//  Created by Bartłomiej on 27/10/2022.
//

import SwiftUI

struct CountryListView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: CountryListViewModel
    @Binding var selectedFlag: String?
    
    var body: some View {
        NavigationView {
            List(selection: $selectedFlag) {
                ForEach(NSLocale.isoCountryCodes, id: \.self) { countryCode in
                    HStack {
                        Text(viewModel.getCountryFlag(countryCode))
                        Text(viewModel.getCountryName(countryCode))
                    }
                }
            }
            .onChange(of: selectedFlag, perform: { _ in
                dismiss()
            })
            .navigationTitle("Choose country")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationButton(type: .close) {
                        dismiss()
                    }
                }
            }
        }
    }
}


struct CountryListView_Previews: PreviewProvider {
    static var previews: some View {
        CountryListView(viewModel: CountryListViewModel(countryFlagService: CountryFlagServiceImpl()), selectedFlag: .constant(nil))
    }
}
