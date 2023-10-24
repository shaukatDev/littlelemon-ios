//
//  littlelemonApp.swift
//  littlelemon
//
//  Created by Ali on 24/10/23.
//

import SwiftUI

@main
struct littlelemonApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
