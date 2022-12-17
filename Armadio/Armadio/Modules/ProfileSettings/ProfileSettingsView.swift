//
//  ProfileSettingsView.swift
//  Armadio
//
//  Created by Bartłomiej on 03/12/2022.
//

import SwiftUI

/// ProfileSettings view showing start point of user settings.
struct ProfileSettingsView: View {
    
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
