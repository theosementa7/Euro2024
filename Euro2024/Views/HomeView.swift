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
    @ObservedObject var vm = DataViewModel.shared
    
    // String Variable
    @State private var searchText: String = ""
    
    // Computed Variables
    var searchResults: [GroupEntity] {
        if searchText.isEmpty {
            return vm.groups
        } else {
            return vm.groups.filter({ $0.teams.contains(where: { $0.name.localizedCaseInsensitiveContains(searchText) }) })
        }
    }

    //MARK: - body
    var body: some View {
        NavigationStack {
            List {
                if searchResults.isEmpty && vm.groups.isEmpty {
                    Section {
                        ForEach(vm.teams.sorted(by: { $0.name < $1.name })) { team in
                            Text(team.name)
                        }
                    }
                } else if !searchResults.isEmpty {
                    ForEach(searchResults.sorted(by: { $0.name < $1.name })) { group in
                        Section(content: {
                            ForEach(group.teams.sorted(by: { $0.scoreOfTeam > $1.scoreOfTeam })) { team in
                                NavigationLink(destination: {
                                    MatchCalendarView(teamSelected: team, group: group)
                                }, label: {
                                    HStack {
                                        Text(team.name)
                                        Spacer()
                                        Text(team.scoreOfTeam.formatted() + "pts")
                                    }
                                })
                            }
                        }, header: {
                            Text("Groupe \(group.name)")
                        })
                    }
                }
                
                Rectangle()
                    .foregroundStyle(Color.clear)
                    .frame(height: 40)
                    .listRowBackground(Color.clear)
            }
            .scrollIndicators(.hidden)
            .overlay {
                if searchResults.isEmpty && !vm.groups.isEmpty {
                    ContentUnavailableView(label: {
                        Label("Pays introuvable", systemImage: "person.3.fill")
                    }, description: {
                        Text("Ce pays n'est pas séléctionnée.")
                    }, actions: { })
                }
            }
            .overlay(alignment: .bottom) {
                Button(action: {
                    if vm.groups.isEmpty {
                        vm.createGroups()
                    } else {
                        for group in vm.groups {
                            vm.createMatchesForGroup(group: group)
                        }
                    }
                }, label: {
                    HStack {
                        Spacer()
                        Text(vm.groups.isEmpty ? "Tirer au sort" : "Jouer les matchs")
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
}
