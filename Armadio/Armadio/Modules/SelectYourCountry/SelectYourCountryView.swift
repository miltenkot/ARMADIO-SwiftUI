//
//  SelectYourCountryView.swift
//  Armadio
//
//  Created by Bartłomiej on 27/10/2022.
//

import SwiftUI

struct SelectYourCountryView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: SelectYourCountryViewModel
    @State private var numberOfShakes = 0.0
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                HStack {
                    Text("SelectYourCountryView_Welcome".localized)
                        .textStyle(TitleStyle(foregroundColor: Color.themeColor(.primaryText)))
                    Spacer()
                }.padding()
                Text("SelectYourCountryView_Please".localized)
                    .foregroundColor(.gray)
                
                Button {
                    viewModel.isDisplayed.toggle()
                } label: {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("SelectYourCountryView_Armadio".localized)
                                .font(.system(size: 12, weight: .light))
                            HStack {
                                Text(viewModel.getCountryFlag())
                                Text(viewModel.getCountryName())
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
                    CountryListView(viewModel: CountryListViewModel(countryFlagService: CountryFlagServiceImpl()), selectedFlag: $viewModel.countryCode)
                        .presentationDetents([.large])
                        .presentationDragIndicator(.visible)
                    
                }
                VStack() {
                    HStack {
                        CheckboxView(readMoreAction: {
                        }, checkState: $viewModel.checkboxState)
                        .shake(with: numberOfShakes)
                        Spacer()
                    }
                    
                    if numberOfShakes > 0 {
                        withAnimation {
                            RequiredView().transition(.fadeAndSlide)
                            
                        }
                    }
                }
                .padding()
                
                Spacer()
                
                ContinueButton(text: "SelectYourCountryView_Continue".localized,
                               foregroundColor: Color.themeColor(.primaryButtonFColor),
                               backgroundColor: .blue,
                               imageName: nil) {
                    if viewModel.checkboxState == false {
                        withAnimation {
                            numberOfShakes += 3
                        }
                    } else {
                        numberOfShakes = 0
                    }
                }
            }
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

struct SelectYourCountryView_Previews: PreviewProvider {
    static var previews: some View {
        SelectYourCountryView(viewModel: SelectYourCountryViewModel(countryFlagService: CountryFlagServiceImpl()))
    }
}

extension AnyTransition {
    static var fadeAndSlide: AnyTransition {
        AnyTransition.opacity.combined(with: .move(edge: .trailing))
    }
}
