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
                NavigationPickerLabel(title: "Country:", content: countryLabel)
            }
            .listRowSeparator(.hidden, edges: .top)
            
            NavigationLink {
                
            } label: {
                NavigationPickerLabel(title: "Email:", content: emailLabel)
            }
            
            NavigationLink {
                
            } label: {
                NavigationPickerLabel(title: "Name:", content: nameLabel)
            }
            
            if authViewModel.currentUserInfo() != nil {
                PrimaryButton(text: "Log out", foregroundColor: .red, backgroundColor: .red.opacity(0.2)) {
                    authViewModel.signOut()
                }
                .padding(.horizontal)
                .listRowSeparator(.hidden, edges: .bottom)
            }
        }
        .navigationBarBackButtonHidden(true)
        .listStyle(.plain)
        .navigationTitle("Account")
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
}

struct AccountList_Previews: PreviewProvider {
    static let authViewModel = AuthenticationViewModel()
    static var previews: some View {
        AccountList()
            .environmentObject(authViewModel)
    }
}
