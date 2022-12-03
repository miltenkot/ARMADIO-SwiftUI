//
//  ContentView.swift
//  Armadio
//
//  Created by Bartłomiej on 27/10/2022.
//

import SwiftUI
import Factory

struct ContentView: View {
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    
    var body: some View {
        Group {
            switch authViewModel.state {
            case .signedIn(_):
                HomeView()
            case .signedOut:
                GetStartedView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static let authViewModel = AuthenticationViewModel()
    static var previews: some View {
        ContentView()
            .environmentObject(authViewModel)
    }
}
