//
//  CoreDataSwiftUI4App.swift
//  CoreDataSwiftUI4
//
//  Created by Alex Nagy on 25.08.2022.
//

import SwiftUI

@main
struct CoreDataSwiftUI4App: App {
    
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView()
            }
            .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
