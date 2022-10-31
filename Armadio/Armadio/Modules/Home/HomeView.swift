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
            Text("Now")
                .tabItem {
                    Label("HomeView_Now".localized, systemImage: "figure.wave")
                }
            WardrobeView()
                .tabItem {
                    Label("HomeView_Wardrobe".localized, systemImage: "cabinet.fill")
                }
            Text("Marketplace")
                .tabItem {
                    Label("HomeView_Marketplace".localized, systemImage: "cart.circle.fill")
                }
            Text("Chat")
                .tabItem {
                    Label("HomeView_Chat".localized, systemImage: "ellipsis.bubble.fill")
                }
            Text("Profile")
                .tabItem {
                    Label("HomeView_Profile".localized, systemImage: "person.circle.fill")
                }
            
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
