//
//  ArmadioApp.swift
//  Armadio
//
//  Created by Bartłomiej on 27/10/2022.
//

import SwiftUI
import Firebase
import CoreData

@main
struct ArmadioApp: App {
    @StateObject private var coreDataStack = CoreDataStack()
    
    init() {
        setupFirebase()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, coreDataStack.container.viewContext)
        }
    }
}

extension ArmadioApp {
    func setupFirebase() {
        #if !DEBUG
        FirebaseApp.configure()
        #endif
    }
}
