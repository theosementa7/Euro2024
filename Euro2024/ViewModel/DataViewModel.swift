//
//  DataViewModel.swift
//  Euro2024
//
//  Created by KaayZenn on 19/12/2023.
//

import Foundation
import CoreData

class DataViewModel: ObservableObject {
    static let shared = DataViewModel()
    let context = PersistenceController.shared.container.viewContext
    
    @Published var groups: [GroupEntity] = []
    @Published var teams: [TeamEntity] = []
    
    @Published var teamsWithHat1: [TeamEntity] = []
    @Published var teamsWithHat2: [TeamEntity] = []
    @Published var teamsWithHat3: [TeamEntity] = []
    @Published var teamsWithHat4: [TeamEntity] = []
    @Published var teamsWithPlayoff: [TeamEntity] = []
    
    init() {
        fetchTeams { result in
            print("🔥 RESULTS : \(result)")
            if !result {
                self.createTeams()
                self.fetchTeams { _ in }
            }
        }
        fetchGroups()
    }
    
    func fetchGroups() {
        let request = NSFetchRequest<GroupEntity>(entityName: "GroupEntity")
        
        do {
            self.groups = try context.fetch(request)
        } catch {
            print("⚠️ \(error.localizedDescription)")
        }
    }
    
    func fetchTeams(completion: @escaping (Bool) -> Void) {
        let request = NSFetchRequest<TeamEntity>(entityName: "TeamEntity")
        let context = PersistenceController.shared.container.viewContext
        do {
            self.teams = try context.fetch(request)
            if teams.isEmpty {
                completion(false)
            } else {
                completion(true)
            }
        } catch {
            print("⚠️ \(error.localizedDescription)")
            completion(false)
        }
    }
}

extension DataViewModel {
    
    func filterTeamsByHat() {
        teamsWithPlayoff = teams.filter({ $0.playoff != "" }).shuffled()
        let teamsOf3WithPayOff = teamsWithPlayoff.suffix(3)
        
        teamsWithHat1 = teams.filter { $0.hat == 1 && $0.playoff == "" }.shuffled()
        teamsWithHat2 = teams.filter { $0.hat == 2 && $0.playoff == "" }.shuffled()
        teamsWithHat3 = teams.filter { $0.hat == 3 && $0.playoff == "" }.shuffled()
        teamsWithHat4 = (teams.filter({ $0.hat == 4 && $0.playoff == "" }) + teamsOf3WithPayOff).shuffled()
    }
    
}

//MARK: - Creation
extension DataViewModel {
    
    func createTeams() {
        for soccerTeam in teamsData {
            let teamEntity = TeamEntity(context: context)
            teamEntity.id = UUID()
            teamEntity.name = soccerTeam.name
            teamEntity.primaryColor = soccerTeam.primaryColor
            teamEntity.secondaryColor = soccerTeam.secondaryColor
            teamEntity.fifaRanking = Int16(soccerTeam.fifaRanking)
            teamEntity.code = soccerTeam.code
            teamEntity.hat = Int16(soccerTeam.hat)
            teamEntity.playoff = soccerTeam.playoff
            
            do {
                try context.save()
            } catch {
                print("⚠️ \(error.localizedDescription)")
            }
        }
    }
    
    func createGroups() {
        if !groups.isEmpty {
            for group in groups {
                context.delete(group)
            }
            
            fetchGroups()
            
            do {
                try context.save()
            } catch {
                print("⚠️ \(error.localizedDescription)")
            }
        }
        
        filterTeamsByHat()
        
        let groupA = GroupEntity(context: context)
        groupA.id = UUID()
        groupA.name = "A"
        groupA.groupToTeam?.insert(teamsWithHat1.removeFirst())
        groupA.groupToTeam?.insert(teamsWithHat2.removeFirst())
        groupA.groupToTeam?.insert(teamsWithHat3.removeFirst())
        groupA.groupToTeam?.insert(teamsWithHat4.removeFirst())
        
        let groupB = GroupEntity(context: context)
        groupB.id = UUID()
        groupB.name = "B"
        groupB.groupToTeam?.insert(teamsWithHat1.removeFirst())
        groupB.groupToTeam?.insert(teamsWithHat2.removeFirst())
        groupB.groupToTeam?.insert(teamsWithHat3.removeFirst())
        groupB.groupToTeam?.insert(teamsWithHat4.removeFirst())
        
        let groupC = GroupEntity(context: context)
        groupC.id = UUID()
        groupC.name = "C"
        groupC.groupToTeam?.insert(teamsWithHat1.removeFirst())
        groupC.groupToTeam?.insert(teamsWithHat2.removeFirst())
        groupC.groupToTeam?.insert(teamsWithHat3.removeFirst())
        groupC.groupToTeam?.insert(teamsWithHat4.removeFirst())
        
        let groupD = GroupEntity(context: context)
        groupD.id = UUID()
        groupD.name = "D"
        groupD.groupToTeam?.insert(teamsWithHat1.removeFirst())
        groupD.groupToTeam?.insert(teamsWithHat2.removeFirst())
        groupD.groupToTeam?.insert(teamsWithHat3.removeFirst())
        groupD.groupToTeam?.insert(teamsWithHat4.removeFirst())
        
        let groupE = GroupEntity(context: context)
        groupE.id = UUID()
        groupE.name = "E"
        groupE.groupToTeam?.insert(teamsWithHat1.removeFirst())
        groupE.groupToTeam?.insert(teamsWithHat2.removeFirst())
        groupE.groupToTeam?.insert(teamsWithHat3.removeFirst())
        groupE.groupToTeam?.insert(teamsWithHat4.removeFirst())
        
        let groupF = GroupEntity(context: context)
        groupF.id = UUID()
        groupF.name = "F"
        groupF.groupToTeam?.insert(teamsWithHat1.removeFirst())
        groupF.groupToTeam?.insert(teamsWithHat2.removeFirst())
        groupF.groupToTeam?.insert(teamsWithHat3.removeFirst())
        groupF.groupToTeam?.insert(teamsWithHat4.removeFirst())
        
        do {
            try context.save()
        } catch {
            print("Error saving group: \(error)")
        }
        
        fetchGroups()
    }
    
}
