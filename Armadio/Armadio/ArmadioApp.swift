//
//  ArmadioApp.swift
//  Armadio
//
//  Created by Bartłomiej on 27/10/2022.
//

import SwiftUI
import Firebase
import CoreData
import GoogleSignIn
import FirebaseCore

/// Root object of app.
@main
struct ArmadioApp: App {
    @StateObject private var coreDataStack = CoreDataStack()
    @StateObject private var authViewModel = AuthenticationViewModel()
    
    init() {
        setupFirebase()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authViewModel)
                .onAppear {
                    authViewModel.restorePreviousSignIn()
                }
                .environment(\.managedObjectContext, coreDataStack.container.viewContext)
                .onOpenURL { url in
                    GIDSignIn.sharedInstance.handle(url)
                }
        }
    }
}

extension ArmadioApp {
    func setupFirebase() {
        FirebaseApp.configure()
    }
}
