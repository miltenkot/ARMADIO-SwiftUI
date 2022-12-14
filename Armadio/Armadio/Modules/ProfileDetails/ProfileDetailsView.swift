//
//  ProfileDetailsView.swift
//  Armadio
//
//  Created by Bartłomiej on 30/11/2022.
//

import SwiftUI

struct ProfileDetailsView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = ProfileDetailsViewModel()
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                HStack {
                    Text("ProfileDetailsView_Title".localized)
                        .textStyle(TitleStyle(foregroundColor: Color.themeColor(.primaryText)))
                    Spacer()
                }.padding()
                CountryPickerView(countryCode: $viewModel.countryCode)
                Group {
                    UserFormTextField(text: $viewModel.emailText, type: .email)
                        .shake(with: viewModel.numberOfShakes)
                    UserFormTextField(text: $viewModel.firstNameText, type: .firstName)
                        .shake(with: viewModel.numberOfShakes)
                    UserFormTextField(text: $viewModel.lastNameText, type: .lastName)
                        .shake(with: viewModel.numberOfShakes)
                }
                .padding()
                VStack() {
                    HStack {
                        CheckboxView(readMoreAction: {
                        }, checkState: $viewModel.checkboxState)
                        .shake(with: viewModel.numberOfShakes)
                        Spacer()
                    }
                }
                .padding()
                Spacer()
                Button("ProfileDetailsView_account".localized) {
                    viewModel.isLoginScreenPresented.toggle()
                }
                .foregroundColor(Color.themeColor(.primaryColor))
                PrimaryButton(text: "ProfileDetailsView_Next".localized, foregroundColor: Color.themeColor(.primaryButtonFColor),
                              backgroundColor: Color.themeColor(.primaryColor)) {
                    if viewModel.validateFields {
                        withAnimation {
                            viewModel.startShakeAnimate()
                        }
                    } else {
                        viewModel.clearShakeAnimate()
                        viewModel.isMainViewPresented.toggle()
                    }
                }
                              .fullScreenCover(isPresented: $viewModel.isMainViewPresented) {
                                  PasswordDetailsView(viewModel: .init(userEmail: viewModel.emailText, userFirstName: viewModel.firstNameText, userLastName: viewModel.lastNameText, userCountryCode: viewModel.countryCode))
                              }
                              .fullScreenCover(isPresented: $viewModel.isLoginScreenPresented) {
                                  SignInView()
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

struct ProfileDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileDetailsView()
    }
}
