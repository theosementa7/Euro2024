//
//  ContentView.swift
//  Euro2024
//
//  Created by KaayZenn on 19/12/2023.
//

import SwiftUI
import CoreData

struct HomeView: View {
    
    // Custom Type
    @ObservedObject var teamManager = TeamManager.shared
    
    // String Variable
    @State private var searchText: String = ""
    
    // Computed Variables
    var searchResults: [GroupTeam] {
        if searchText.isEmpty {
            return teamManager.groups
        } else {
            return teamManager.groups.filter({ $0.teams.contains(where: { $0.name.localizedCaseInsensitiveContains(searchText) }) })
        }
    }

    //MARK: - body
    var body: some View {
        NavigationStack {
            List(searchResults) { group in
                Section(content: {
                    ForEach(group.teams) { team in
                        Text(team.name)
                    }
                }, header: {
                    Text("Groupe \(group.title)")
                })
                
                if let lastItem = searchResults.last {
                    if lastItem.id == group.id {
                        Rectangle()
                            .foregroundStyle(Color.clear)
                            .frame(height: 40)
                            .listRowBackground(Color.clear)
                    }
                }
            }
            .scrollIndicators(.hidden)
            .overlay(alignment: .bottom) {
                Button(action: { teamManager.createGroups() }, label: {
                    HStack {
                        Spacer()
                        Text("Tirer au sort")
                            .foregroundStyle(.white)
                            .font(.system(size: 18, weight: .semibold, design: .rounded))
                        Spacer()
                    }
                    .padding()
                    .background(Capsule().foregroundStyle(.blue))
                    .padding(.horizontal)
                })
                .background(
                    LinearGradient(stops: [
                        Gradient.Stop(color: Color(uiColor: UIColor.systemBackground).opacity(0), location: 0.00),
                        Gradient.Stop(color: Color(uiColor: UIColor.systemBackground), location: 1.00)
                    ], startPoint: UnitPoint(x: 0.5, y: 0), endPoint: UnitPoint(x: 0.5, y: 0.27))
                )
            }
            .navigationTitle("Euro2024")
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Rechercher un pays...")
        }
    } // End body

} // End struct

//MARK: - Preview
#Preview {
    HomeView()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
