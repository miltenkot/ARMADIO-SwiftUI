//
//  SignInView.swift
//  Armadio
//
//  Created by Bartłomiej on 04/12/2022.
//

import SwiftUI

struct SignInView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    @StateObject var viewModel = SignInViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: Constants.spacingZero) {
                VStack {
                    Spacer()
                    HStack {
                        VStack(alignment: .leading, spacing: Constants.spacingSmall) {
                            Text("SignInView_LogIn".localized)
                                .textStyle(TitleStyle(foregroundColor: Color.themeColor(.primaryText)))
                            Text("SignInView_PassAndEmail".localized)
                                .font(.system(size: Constants.fontSmall, weight: .light))
                                .foregroundColor(Color.themeColor(.primaryText))
                        }
                        Spacer()
                    }
                    Group {
                        UserFormTextField(text: $viewModel.emailText, type: .email)
                            .shake(with: viewModel.numberOfShakes)
                        UserFormTextField(text: $viewModel.passwordText, type: .password)
                            .shake(with: viewModel.numberOfShakes)
                    }.padding(.vertical, Constants.paddingVerticalSmall)
                    Spacer()
                    PrimaryAsyncButton(text: "SignInView_SignIn".localized, foregroundColor: Color.themeColor(.primaryButtonFColor),
                                       backgroundColor: .blue) {
                        if viewModel.validateFields {
                            withAnimation {
                                viewModel.startShakeAnimate()
                            }
                        } else {
                            Task {
                                let result = await authViewModel.signInWithEmail(
                                    email: viewModel.emailText,
                                    password: viewModel.passwordText
                                )
                                
                                switch result {
                                case .success:
                                    #warning("here is bug our sheet doesn't dismiss")
                                    dismiss()
                                case .failure:
                                    viewModel.showingErrorAlert.toggle()
                                }
                            }
                        }
                    }
                }.padding()
            }
            .alert("SignInView_UserNotFound".localized, isPresented: $viewModel.showingErrorAlert, actions: {
                Button("OK", role: .cancel) { }
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

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
