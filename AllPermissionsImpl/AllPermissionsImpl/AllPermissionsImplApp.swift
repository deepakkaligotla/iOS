//
//  AllPermissionsImplApp.swift
//  AllPermissionsImpl
//
//  Created by Deepak Kaligotla on 19/04/24.
//

import SwiftUI
import SwiftData

@main
struct AllPermissionsImplApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            PermissionModel.self,
        ])
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
