//
//  ContentView.swift
//  Euro2024
//
//  Created by KaayZenn on 19/12/2023.
//

import SwiftUI
import CoreData

struct HomeView: View {

    var body: some View {
        NavigationStack {
            Text(teamsData.count.formatted())
        }
    }
    
}

#Preview {
    HomeView()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
