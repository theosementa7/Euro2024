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
    
    // Bool Variables
    @State private var update: Bool = false
    
    // Computed Variables
    var searchResults: [GroupEntity] {
        if searchText.isEmpty {
            return vm.groups
        } else {
            return vm.groups.filter({ $0.teams.contains(where: { $0.name.localizedCaseInsensitiveContains(searchText) }) })
        }
    }
    
    var winner: TeamEntity? {
        return vm.teams.filter({ $0.isWinner }).first
    }

    //MARK: - body
    var body: some View {
        NavigationStack {
            List {
                if let winner {
                    HStack {
                        Text(winner.name)
                        Spacer()
                        Text(winner.score.formatted() + "pts")
                    }
                } else if !vm.lastTwoTeams.isEmpty {
                    listOfTeams(teams: vm.lastTwoTeams)
                } else if !vm.lastFourTeams.isEmpty {
                    listOfTeams(teams: vm.lastFourTeams)
                } else if !vm.lastEightTeams.isEmpty {
                    listOfTeams(teams: vm.lastEightTeams)
                } else if !vm.lastSixteenTeams.isEmpty {
                    listOfTeams(teams: vm.lastSixteenTeams)
                } else {
                    if searchResults.isEmpty && vm.groups.isEmpty {
                        Section {
                            ForEach(vm.teams.sorted(by: { $0.name < $1.name })) { team in
                                Text(team.name)
                            }
                        }
                    } else if !searchResults.isEmpty {
                        ForEach(searchResults.sorted(by: { $0.name < $1.name })) { group in
                            Section(content: {
                                listOfTeams(teams: group.teams)
                            }, header: {
                                Text("Groupe \(group.name)")
                            })
                        }
                    }
                }
                
                Section {
                    Rectangle()
                        .foregroundStyle(Color.clear)
                        .frame(height: 40)
                        .listRowBackground(Color.clear)
                }
            }
            .padding(update ? 0 : 0)
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
                    buttonAction()
                }, label: {
                    HStack {
                        Spacer()
                        Text(buttonText())
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
            .onAppear {
                
            }
        }
    } // End body
    
    @ViewBuilder
    func listOfTeams(teams: [TeamEntity]) -> some View {
        ForEach(teams.sorted(by: { $0.score > $1.score })) { team in
            NavigationLink(destination: {
                if let group = team.teamToGroup {
                    MatchCalendarView(teamSelected: team, group: group)
                }
            }, label: {
                HStack {
                    Text(team.name)
                    Spacer()
                    Text(team.score.formatted() + "pts")
                }
            })
        }
    }
    
    func buttonAction() {
        if winner != nil {
            vm.resetAllData()
        } else if !vm.lastTwoTeams.isEmpty {
            vm.play1MatchForTeams(teams: vm.lastTwoTeams)
            update.toggle()
        } else if !vm.lastFourTeams.isEmpty {
            vm.drawForThe2ThFinal()
            vm.fetchLastTwoTeams()
        } else if !vm.lastEightTeams.isEmpty {
            vm.drawForThe4ThFinal()
            vm.fetchLastFourTeams()
        } else if !vm.lastSixteenTeams.isEmpty {
            vm.drawForThe8ThFinal()
            vm.fetchLastEightTeams()
        } else if vm.groups.isEmpty {
            vm.createGroups()
        } else if vm.matchs.isEmpty && !vm.groups.isEmpty {
            for group in vm.groups {
                vm.createMatchesForGroup(group: group)
                vm.fetchMatch()
            }
        } else {
            vm.drawForThe16ThFinal()
        }
    }
    
    func buttonText() -> String {
        if winner != nil {
            return "Rejouer"
        } else if !vm.lastTwoTeams.isEmpty {
            return "Tirer le vainqueur"
        } else if !vm.lastFourTeams.isEmpty {
            return "Tirer les demi final"
        } else if !vm.lastEightTeams.isEmpty {
            return "Tirer le 1/4 de final"
        } else if !vm.lastSixteenTeams.isEmpty {
            return "Tirer le 8ème de final"
        } else if vm.groups.isEmpty {
            return "Tirer au sort"
        } else if vm.matchs.isEmpty && !vm.groups.isEmpty {
            return "Jouer les matchs"
        } else {
            return "Tirer le 16ème"
        }
    }

} // End struct

//MARK: - Preview
#Preview {
    HomeView()
}
