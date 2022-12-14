//
//  AccountList.swift
//  Armadio
//
//  Created by Bartłomiej on 03/12/2022.
//

import SwiftUI

struct AccountList: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = AccountListViewModel()
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    
    var body: some View {
        List {
            NavigationLink {
                
            } label: {
                NavigationPickerLabel(title: "AccountList_Country".localized, content: countryLabel)
            }
            .listRowSeparator(.hidden, edges: .top)
            
            NavigationLink {
                
            } label: {
                NavigationPickerLabel(title: "AccountList_Email".localized, content: emailLabel)
            }
            
            NavigationLink {
                
            } label: {
                NavigationPickerLabel(title: "AccountList_Name".localized, content: nameLabel)
            }
            
            NavigationLink {
                
            } label: {
                NavigationPickerLabel(title: "AccountList_Phone".localized, content: phoneLabel)
            }
            
            if authViewModel.currentUserInfo() != nil {
                PrimaryButton(text: "AccountList_LogOut".localized, foregroundColor: .red, backgroundColor: .red.opacity(0.2)) {
                    authViewModel.signOut()
                }
                .padding(.horizontal)
                .listRowSeparator(.hidden, edges: .bottom)
            }
        }
        .navigationBarBackButtonHidden(true)
        .listStyle(.plain)
        .navigationTitle("AccountList_Account".localized)
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                NavigationButton(type: .back) {
                    dismiss()
                }
            }
        }
    }
}

extension AccountList {
    @ViewBuilder private var countryLabel: some View {
        Text("Country")
    }
    
    @ViewBuilder private var emailLabel: some View {
        Text("\(authViewModel.currentUserInfo()?.email ?? "Empty")")
    }
    
    @ViewBuilder private var nameLabel: some View {
        Text("\(authViewModel.currentUserInfo()?.displayName ?? "Empty")")
    }
    
    @ViewBuilder private var phoneLabel: some View {
        Text("\(authViewModel.currentUserInfo()?.phoneNumber ?? "Empty")")
    }
}

struct AccountList_Previews: PreviewProvider {
    static let authViewModel = AuthenticationViewModel()
    static var previews: some View {
        AccountList()
            .environmentObject(authViewModel)
    }
}
