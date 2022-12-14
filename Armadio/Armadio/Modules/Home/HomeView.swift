//
//  HomeView.swift
//  Armadio
//
//  Created by Bartłomiej on 29/10/2022.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        TabView {
            NowView()
                .tabItem {
                    Label("HomeView_Now".localized, systemImage: "figure.wave")
                }
            WardrobeView()
                .tabItem {
                    Label("HomeView_Wardrobe".localized, systemImage: "cabinet.fill")
                }
            Text("Marketplace is not available yet.")
                .tabItem {
                    Label("HomeView_Marketplace".localized, systemImage: "cart.circle.fill")
                }
            Text("Chat is not available yet.")
                .tabItem {
                    Label("HomeView_Chat".localized, systemImage: "ellipsis.bubble.fill")
                }
            ProfileSettingsView()
                .tabItem {
                    Label("HomeView_Profile".localized, systemImage: "person.circle.fill")
                }
            
        }
        .accentColor(Color.themeColor(.primaryColor))
    }
}

struct HomeView_Previews: PreviewProvider {
    static var coreDataStack = CoreDataStack.preview
    static var previews: some View {
        HomeView()
            .environment(\.managedObjectContext, coreDataStack.container.viewContext)
    }
}
