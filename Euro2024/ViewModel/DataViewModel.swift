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
    @Published var matchs: [MatchEntity] = []
    
    @Published var lastSixteenTeams: [TeamEntity] = []
    @Published var lastEightTeams: [TeamEntity] = []
    @Published var lastFourTeams: [TeamEntity] = []
    @Published var lastTwoTeams: [TeamEntity] = []
    
    @Published var teamsWithHat1: [TeamEntity] = []
    @Published var teamsWithHat2: [TeamEntity] = []
    @Published var teamsWithHat3: [TeamEntity] = []
    @Published var teamsWithHat4: [TeamEntity] = []
    @Published var teamsWithPlayoff: [TeamEntity] = []
    
    init() {
        fetchTeams { result in
            if !result {
                self.createTeams()
                self.fetchTeams { _ in }
            }
        }
        fetchGroups()
        fetchMatch()
        fetchLastSixteenTeams()
        fetchLastEightTeams()
        fetchLastFourTeams()
        fetchLastTwoTeams()
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
    
    func fetchMatch() {
        let request: NSFetchRequest<MatchEntity> = MatchEntity.fetchRequest()
        
        do {
            self.matchs = try context.fetch(request)
        } catch {
            print("⚠️ \(error.localizedDescription)")
        }
    }
    
    func resetAllData() {
        let entityNames = ["MatchEntity", "TeamEntity", "GroupEntity"]
        
        for entityName in entityNames {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            
            do {
                try context.execute(batchDeleteRequest)
                print("All records for \(entityName) deleted successfully.")
            } catch {
                print("Error deleting records for \(entityName): \(error.localizedDescription)")
            }
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

extension DataViewModel {
    
    func play8MatchForTeams(teams: [TeamEntity]) {
        createMatch(teamA: teams[0], teamB: teams[1])
        createMatch(teamA: teams[2], teamB: teams[3])
        createMatch(teamA: teams[4], teamB: teams[5])
        createMatch(teamA: teams[6], teamB: teams[7])
        createMatch(teamA: teams[8], teamB: teams[9])
        createMatch(teamA: teams[10], teamB: teams[11])
        createMatch(teamA: teams[12], teamB: teams[13])
        createMatch(teamA: teams[14], teamB: teams[15])
    }
    
    func play4MatchForTeams(teams: [TeamEntity]) {
        createMatch(teamA: teams[0], teamB: teams[1])
        createMatch(teamA: teams[2], teamB: teams[3])
        createMatch(teamA: teams[4], teamB: teams[5])
        createMatch(teamA: teams[6], teamB: teams[7])
    }
    
    func play2MatchForTeams(teams: [TeamEntity]) {
        createMatch(teamA: teams[0], teamB: teams[1])
        createMatch(teamA: teams[2], teamB: teams[3])
    }
    
    func play1MatchForTeams(teams: [TeamEntity]) {
        createMatch(teamA: teams[0], teamB: teams[1])
        
        if teams[0].score > teams[1].score {
            teams[0].isWinner = true
        } else if teams[0].score < teams[1].score {
            teams[1].isWinner = true
        } else {
            
        }
        
        do {
            try context.save()
        } catch {
            print("⚠️ \(error.localizedDescription)")
        }
    }
    
    func createMatch(teamA: TeamEntity, teamB: TeamEntity) {
        let match = MatchEntity(context: context)
        match.id = UUID()
        match.teamOne = teamA
        match.teamTwo = teamB
        match.scoreTeamOne = Int16(Int.random(in: 0...4)) // Int16(generateScoreWithFIFARanking(team: teamA))
        match.scoreTeamTwo = Int16(Int.random(in: 0...4)) // Int16(generateScoreWithFIFARanking(team: teamB))
        
        if match.scoreTeamOne > match.scoreTeamTwo {
            teamA.score += 3
        } else if match.scoreTeamOne < match.scoreTeamTwo {
            teamB.score += 3
        } else {
            teamA.score += 1
            teamB.score += 1
        }

        // Enregistre le match
        do {
            try context.save()
        } catch {
            print("Error saving match: \(error)")
        }
    }
    
}

extension DataViewModel {
    
    func drawForThe16ThFinal() {
        let teamsSorted = teams.sorted {
            if $0.score == $1.score {
                return $0.numberOfGoalScored() > $1.numberOfGoalScored()
            } else {
                return $0.score > $1.score
            }
        }

        let teamsFiltered = Array(teamsSorted.prefix(16))
        self.lastSixteenTeams = teamsFiltered
        
        for team in teamsFiltered { team.isIn16 = true }
        
        play8MatchForTeams(teams: teamsFiltered)
        
        do {
            try context.save()
        } catch {
            print("⚠️ \(error.localizedDescription)")
        }
    }
    
    func fetchLastSixteenTeams() {
        let lastTeams = teams.filter({ $0.isIn16 })
        self.lastSixteenTeams = lastTeams
    }
    
    func drawForThe8ThFinal() {
        let teamsSorted = teams.sorted {
            if $0.score == $1.score {
                return $0.numberOfGoalScored() > $1.numberOfGoalScored()
            } else {
                return $0.score > $1.score
            }
        }

        let teamsFiltered = Array(teamsSorted.prefix(8))
        self.lastSixteenTeams = teamsFiltered
        
        for team in teamsFiltered { team.isIn8 = true }
        
        play4MatchForTeams(teams: teamsFiltered)
        
        do {
            try context.save()
        } catch {
            print("⚠️ \(error.localizedDescription)")
        }
    }
    
    func fetchLastEightTeams() {
        let lastTeams = teams.filter({ $0.isIn8 })
        self.lastEightTeams = lastTeams
    }
    
    func drawForThe4ThFinal() {
        let teamsSorted = teams.sorted {
            if $0.score == $1.score {
                return $0.numberOfGoalScored() > $1.numberOfGoalScored()
            } else {
                return $0.score > $1.score
            }
        }

        let teamsFiltered = Array(teamsSorted.prefix(4))
        self.lastSixteenTeams = teamsFiltered
        
        for team in teamsFiltered { team.isIn4 = true }
        
        play2MatchForTeams(teams: teamsFiltered)
        
        do {
            try context.save()
        } catch {
            print("⚠️ \(error.localizedDescription)")
        }
    }
    
    func fetchLastFourTeams() {
        let lastTeams = teams.filter({ $0.isIn4 })
        self.lastFourTeams = lastTeams
    }
    
    func drawForThe2ThFinal() {
        let teamsSorted = teams.sorted {
            if $0.score == $1.score {
                return $0.numberOfGoalScored() > $1.numberOfGoalScored()
            } else {
                return $0.score > $1.score
            }
        }

        let teamsFiltered = Array(teamsSorted.prefix(2))
        self.lastSixteenTeams = teamsFiltered
        
        for team in teamsFiltered { team.isIn2 = true }
                
        do {
            try context.save()
        } catch {
            print("⚠️ \(error.localizedDescription)")
        }
    }
    
    func fetchLastTwoTeams() {
        let lastTeams = teams.filter({ $0.isIn2 })
        self.lastTwoTeams = lastTeams
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
    
    func createMatchesForGroup(group: GroupEntity) {
        let teams = group.teams
        let matchs = group.matchs

        for (index, teamA) in teams.enumerated() {
            for j in index+1..<teams.count {
                let teamB = teams[j]

                // Vérifie si ce match n'existe pas déjà
                if !matchExistsBetweenTeams(teamA: teamA, teamB: teamB, matchs: matchs) {
                    // Crée un match entre les équipes
                    let match = MatchEntity(context: context)
                    match.id = UUID()
                    match.teamOne = teamA
                    match.teamTwo = teamB
                    match.scoreTeamOne = Int16(Int.random(in: 0...4)) // Int16(generateScoreWithFIFARanking(team: teamA))
                    match.scoreTeamTwo = Int16(Int.random(in: 0...4)) // Int16(generateScoreWithFIFARanking(team: teamB))
                    match.matchToGroup = group

                    if match.scoreTeamOne > match.scoreTeamTwo {
                        teamA.score += 3
                    } else if match.scoreTeamOne < match.scoreTeamTwo {
                        teamB.score += 3
                    } else {
                        teamA.score += 1
                        teamB.score += 1
                    }
                    
                    // Enregistre le match
                    do {
                        try context.save()
                    } catch {
                        print("Error saving match: \(error)")
                    }
                }
            }
        }

        fetchGroups()
    }

    func matchExistsBetweenTeams(teamA: TeamEntity, teamB: TeamEntity, matchs: [MatchEntity]) -> Bool {
        for match in matchs {
            if match.teamOne == teamA && match.teamTwo == teamB {
                return true
            }
            if match.teamTwo == teamA && match.teamOne == teamB {
                return true
            }
        }
        return false
    }

    func generateScoreWithFIFARanking(team: TeamEntity) -> Int {
        let averageGoals: Double = 2.37
        let fifaRanking = Int(team.fifaRanking)

        let rankingFactor = 1.0 - Double(fifaRanking) / 100.0

        let standardDeviation: Double = 0.24

        let goals = Int(round((averageGoals + standardDeviation * Double.random(in: -1...1)) * rankingFactor))

        return goals
    }
    
}



//    func drawForThe8ThFinal() {
//        var lastTeams: [TeamEntity] = []
//
//        if let groupA = groups.filter({ $0.name == "A" }).first {
//            let teamsFiltered = filterTeams(teams: groupA.teams)
//            for team in teamsFiltered {
//                lastTeams.append(team)
//            }
//            groupA.groupToTeam?.removeAll()
//            groupA.groupToTeam = Set(teamsFiltered)
//        }
//
//        if let groupB = groups.filter({ $0.name == "B" }).first {
//            let teamsFiltered = filterTeams(teams: groupB.teams)
//            for team in teamsFiltered {
//                lastTeams.append(team)
//            }
//            groupB.groupToTeam?.removeAll()
//            groupB.groupToTeam = Set(teamsFiltered)
//        }
//
//        if let groupC = groups.filter({ $0.name == "C" }).first {
//            let teamsFiltered = filterTeams(teams: groupC.teams)
//            for team in teamsFiltered {
//                lastTeams.append(team)
//            }
//            groupC.groupToTeam?.removeAll()
//            groupC.groupToTeam = Set(teamsFiltered)
//        }
//
//        if let groupD = groups.filter({ $0.name == "D" }).first {
//            let teamsFiltered = filterTeams(teams: groupD.teams)
//            for team in teamsFiltered {
//                lastTeams.append(team)
//            }
//            groupD.groupToTeam?.removeAll()
//            groupD.groupToTeam = Set(teamsFiltered)
//        }
//
//        if let groupE = groups.filter({ $0.name == "E" }).first {
//            let teamsFiltered = filterTeams(teams: groupE.teams)
//            for team in teamsFiltered {
//                lastTeams.append(team)
//            }
//            groupE.groupToTeam?.removeAll()
//            groupE.groupToTeam = Set(teamsFiltered)
//        }
//
//        if let groupF = groups.filter({ $0.name == "F" }).first {
//            let teamsFiltered = filterTeams(teams: groupF.teams)
//            for team in teamsFiltered {
//                lastTeams.append(team)
//            }
//            groupF.groupToTeam?.removeAll()
//            groupF.groupToTeam = Set(teamsFiltered)
//        }
//
//        self.lastTwelveTeams = lastTeams
//
//        do {
//            try context.save()
//        } catch {
//            print("⚠️ \(error.localizedDescription)")
//        }
//    }
    
//    func filterTeams(teams: [TeamEntity]) -> [TeamEntity] {
//        let teamsSorted = teams.sorted {
//            if $0.scoreOfTeam == $1.scoreOfTeam {
//                return $0.numberOfGoalScored() > $1.numberOfGoalScored()
//            } else {
//                return $0.scoreOfTeam > $1.scoreOfTeam
//            }
//        }
//
//        let teamsFiltered = Array(teamsSorted.prefix(2))
//        return teamsFiltered
//    }
