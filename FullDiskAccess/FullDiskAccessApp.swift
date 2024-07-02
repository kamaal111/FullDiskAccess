//
//  FullDiskAccessApp.swift
//  FullDiskAccess
//
//  Created by Kamaal M Farah on 02/07/2024.
//

import SwiftUI
import SwiftData

@main
struct FullDiskAccessApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
