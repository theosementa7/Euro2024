//
//  Euro2024App.swift
//  Euro2024
//
//  Created by KaayZenn on 19/12/2023.
//

import SwiftUI

@main
struct Euro2024App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
