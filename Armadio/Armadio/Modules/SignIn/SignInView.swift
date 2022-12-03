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
            VStack(spacing: 0) {
                VStack {
                    Spacer()
                    HStack {
                        VStack(alignment: .leading, spacing: 14) {
                            Text("Log in")
                                .textStyle(TitleStyle(foregroundColor: Color.themeColor(.primaryText)))
                            Text("Login to your service using password and email.")
                                .font(.system(size: 14, weight: .light))
                                .foregroundColor(Color.themeColor(.primaryText))
                        }
                        Spacer()
                    }
                    Group {
                        UserFormTextField(text: $viewModel.emailText, type: .email)
                            .shake(with: viewModel.numberOfShakes)
                        UserFormTextField(text: $viewModel.passwordText, type: .password)
                            .shake(with: viewModel.numberOfShakes)
                    }.padding(.vertical, 5)
                    Spacer()
                    PrimaryAsyncButton(text: "Sign In", foregroundColor: Color.themeColor(.primaryButtonFColor),
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
                                    // here is bug our sheet doesn't dismiss
                                    dismiss()
                                case .failure:
                                    viewModel.showingErrorAlert.toggle()
                                }
                            }
                        }
                    }
                }.padding()
            }
            .alert("User not found", isPresented: $viewModel.showingErrorAlert, actions: {
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
