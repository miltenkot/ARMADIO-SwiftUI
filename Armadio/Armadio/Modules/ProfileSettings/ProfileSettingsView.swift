//
//  ProfileSettingsView.swift
//  Armadio
//
//  Created by Bartłomiej on 03/12/2022.
//

import SwiftUI

struct ProfileSettingsView: View {
    @StateObject var viewModel = ProfileSettingsViewModel()
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink {
                    AccountList()
                } label: {
                    AccountRow()
                }
                .listRowSeparator(.hidden, edges: .top)
            }
            .listStyle(.plain)
            .navigationTitle("ProfileSettingsView_Profile".localized)
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct ProfileSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSettingsView()
    }
}

struct FlatLinkStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
    }
}
