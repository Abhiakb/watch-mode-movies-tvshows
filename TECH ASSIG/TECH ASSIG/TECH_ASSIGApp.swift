//
//  TECH_ASSIGApp.swift
//  TECH ASSIG
//
//  Created by Akhil Gubbala on 17/02/25.
//

import SwiftUI
import SwiftData

@main
struct TECH_ASSIGApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
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
            MovieListView()
        }
        .modelContainer(sharedModelContainer)
    }
}
