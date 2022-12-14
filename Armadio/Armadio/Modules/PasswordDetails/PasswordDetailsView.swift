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
            VStack(spacing: Constants.spacingZero) {
                VStack {
                    VStack(alignment: .leading, spacing: Constants.spacingSmall) {
                        Text("PasswordDetailsView_Password".localized)
                            .textStyle(TitleStyle(foregroundColor: Color.themeColor(.primaryText)))
                        Text("PasswordDetailsView_PasswordNeeds".localized)
                            .font(.system(size: 14, weight: .light))
                            .foregroundColor(Color.themeColor(.primaryText))
                    }
                    Group {
                        UserFormTextField(text: $viewModel.passwordText, type: .password)
                            .shake(with: viewModel.numberOfShakes)
                        UserFormTextField(text: $viewModel.repeatPasswordText, type: .repeatPassword)
                            .shake(with: viewModel.numberOfShakes)
                    }.padding(.vertical, Constants.paddingVerticalSmall)
                    Spacer()
                    PrimaryAsyncButton(text: "PasswordDetailsView_Sign".localized, foregroundColor: Color.themeColor(.primaryButtonFColor),
                                       backgroundColor: Color.themeColor(.primaryColor)) {
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
            .alert("PasswordDetailsView_User".localized, isPresented: $viewModel.showingErrorAlert, actions: {
                Button("PasswordDetailsView_Ok".localized, role: .cancel) { }
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
