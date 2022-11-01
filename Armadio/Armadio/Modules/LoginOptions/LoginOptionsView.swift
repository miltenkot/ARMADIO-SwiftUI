//
//  LoginOptionsView.swift
//  Armadio
//
//  Created by Bartłomiej on 27/10/2022.
//

import SwiftUI

struct LoginOptionsView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = LoginOptionsViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.themeColor(.primarySheet).ignoresSafeArea()
                VStack(alignment: .center, spacing: 40) {
                    
                    VStack(alignment: .leading, spacing: 10) {
                        
                        Text("LoginOptionsView_Get".localized)
                            .textStyle(TitleStyle(foregroundColor: Color.themeColor(.primaryText)))
                        Text("LoginOptionsView_Please".localized)
                            .textStyle(NormalStyle())
                        Text("LoginOptionsView_Please_visit".localized)
                            .font(.system(size: 14, weight: .light))
                            .foregroundColor(Color.themeColor(.primaryText))
                    }
                    
                    VStack(spacing: 0) {
                        PrimaryButton(text: "LoginOptionsView_Apple".localized,
                                       foregroundColor: Color.themeColor(.primaryButtonFColor),
                                       backgroundColor: Color.themeColor(.primaryButtonBColor),
                                       imageName: "applelogo") {
                            print("action")
                        }
                        
                        PrimaryButton(text: "LoginOptionsView_Facebook".localized,
                                       foregroundColor: Color.themeColor(.primaryButtonFColor),
                                       backgroundColor: .blue,
                                       imageName: "f.cursive.circle.fill") {
                            print("action")
                        }
                        
                        PrimaryButton(text: "LoginOptionsView_Google".localized,
                                       foregroundColor: .blue,
                                       backgroundColor: Color.themeColor(.primaryButtonBColor),
                                       imageName: "g.square") {
                            print("action")
                        }
                                       
                        
                        PrimaryButton(text: "LoginOptionsView_email".localized,
                                       foregroundColor: Color.themeColor(.primaryButtonFColor),
                                       backgroundColor: .blue,
                                       imageName: "envelope.fill") {
                            print("action")
                        }
                        
                        Divider().background(.white)
                        PrimaryButton(text: "LoginOptionsView_guest".localized,
                                       foregroundColor: Color.themeColor(.primaryButtonFColor),
                                       backgroundColor: .blue) {
                            viewModel.isPresented.toggle()
                            
                        }
                                       .fullScreenCover(isPresented: $viewModel.isPresented) {
                                           SelectYourCountryView()
                                       }
                        
                    }
                }.padding()
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
}

struct LoginOptionsView_Previews: PreviewProvider {
    static var previews: some View {
        LoginOptionsView()
    }
}
