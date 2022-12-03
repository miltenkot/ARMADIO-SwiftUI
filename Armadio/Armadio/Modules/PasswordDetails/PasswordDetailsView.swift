//
//  PasswordDetailsView.swift
//  Armadio
//
//  Created by Bartłomiej on 01/12/2022.
//

import SwiftUI

struct PasswordDetailsView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    @ObservedObject var viewModel: PasswordDetailsViewModel
    
    init(viewModel: PasswordDetailsViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                VStack {
                    VStack(alignment: .leading, spacing: 14) {
                        Text("Password")
                            .textStyle(TitleStyle(foregroundColor: Color.themeColor(.primaryText)))
                        Text("Password must have more than 8 characters, contain some special character, one digit, one uppercase letter")
                            .font(.system(size: 14, weight: .light))
                            .foregroundColor(Color.themeColor(.primaryText))
                    }
                    Group {
                        UserFormTextField(text: $viewModel.passwordText, type: .password)
                            .shake(with: viewModel.numberOfShakes)
                        UserFormTextField(text: $viewModel.repeatPasswordText, type: .repeatPassword)
                            .shake(with: viewModel.numberOfShakes)
                    }.padding(.vertical, 5)
                    Spacer()
                    PrimaryAsyncButton(text: "Sign Up", foregroundColor: Color.themeColor(.primaryButtonFColor),
                                       backgroundColor: .blue) {
                        if viewModel.validateFields {
                            withAnimation {
                                viewModel.startShakeAnimate()
                            }
                        } else {
                            Task {
                                viewModel.clearShakeAnimate()
                                authViewModel.registerWithEmail(email: viewModel.userEmail, password: viewModel.passwordText)
                                dismiss()
                            }
                            
                        }
                    }    
                }.padding()
            }
            .alert("User is already sign in", isPresented: $viewModel.showingErrorAlert, actions: {
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

struct PasswordDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PasswordDetailsView(viewModel: PasswordDetailsViewModel(userEmail: "", userFirstName: "", userLastName: ""))
    }
}
