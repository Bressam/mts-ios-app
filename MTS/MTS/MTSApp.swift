//
//  MTSApp.swift
//  MTS
//
//  Created by Giovanne Bressam on 09/05/25.
//

import SwiftUI

@main
struct MTSApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
