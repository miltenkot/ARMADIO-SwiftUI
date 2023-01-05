//
//  LoginOptionsView.swift
//  Armadio
//
//  Created by Bartłomiej on 27/10/2022.
//

import SwiftUI
import GoogleSignInSwift
import AuthenticationServices

/// View for selecting one of several login options such as `Google`, `Facebook`, `Apple`, `Email` or `Guest`.
struct LoginOptionsView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    @StateObject var viewModel = LoginOptionsViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.themeColor(.primarySheet).ignoresSafeArea()
                VStack(alignment: .center, spacing: Constants.spacingMedium) {
                    
                    VStack(alignment: .leading, spacing: Constants.spacingSmall) {
                        
                        Text("LoginOptionsView_Get".localized)
                            .textStyle(TitleStyle(foregroundColor: Color.themeColor(.primaryText)))
                        Text("LoginOptionsView_Please".localized)
                            .textStyle(NormalStyle())
                        Text("LoginOptionsView_Please_visit".localized)
                            .font(.system(size: 14, weight: .light))
                            .foregroundColor(Color.themeColor(.primaryText))
                    }
                    
                    VStack(spacing: Constants.spacingZero) {
#warning("TODO: - Add fb and apple login method")
                        
                        PrimaryButton(text: "LoginOptionsView_Facebook".localized,
                                      foregroundColor: Color.themeColor(.primaryButtonFColor),
                                      backgroundColor: Color.themeColor(.primaryColor),
                                      imageName: "f.cursive.circle.fill") {
                            viewModel.facebookLoginNotAvailable.toggle()
                        }
                        
                        PrimaryButton(text: "LoginOptionsView_Google".localized,
                                      foregroundColor: Color.blue,
                                      backgroundColor: Color.themeColor(.primaryButtonBColor),
                                      imageName: "g.square") {
                            authViewModel.signInWithGoogle()
                        }
                        
                        PrimaryButton(text: "LoginOptionsView_email".localized,
                                      foregroundColor: Color.themeColor(.primaryButtonFColor),
                                      backgroundColor: Color.themeColor(.primaryColor),
                                      imageName: "envelope.fill") {
                            viewModel.activeModalView = .email
                        }
                        
                        SignInWithAppleButton(.signIn) { request in
                            authViewModel.handleSignInWithAppleRequest(request)
                        } onCompletion: { result in
                            authViewModel.handleSignInWithAppleCompletion(result)
                        }
                        .frame(width: 300, height: 50)
                        .padding([.top, .bottom], 10)
                        
                        Divider().background(.white)
                        PrimaryButton(text: "LoginOptionsView_guest".localized,
                                      foregroundColor: Color.themeColor(.primaryButtonFColor),
                                      backgroundColor: Color.themeColor(.primaryColor)) {
                            viewModel.activeModalView = .guest
                            
                        }
                                      .fullScreenCover(item: $viewModel.activeModalView) {
                                          switch $0 {
                                          case .email:
                                              ProfileDetailsView()
                                          case .guest:
                                              SelectYourCountryView()
                                          }
                                      }
                                      .alert("Facebook login is not available yet.", isPresented: $viewModel.facebookLoginNotAvailable, actions: {
                                          Button("OK", role: .cancel) { }
                                      })
//                                      .alert("Apple login is not available yet.", isPresented: $viewModel.appleLoginNotAvailable, actions: {
//                                          Button("OK", role: .cancel) { }
//                                      })
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
    static let authViewModel = AuthenticationViewModel()
    static var previews: some View {
        LoginOptionsView()
            .environmentObject(authViewModel)
    }
}
