//
//  TeamManager.swift
//  Euro2024
//
//  Created by KaayZenn on 19/12/2023.
//

import Foundation

class TeamManager: ObservableObject {
    static let shared = TeamManager()
    
    @Published var groups: [GroupTeam] = []
    
}

extension TeamManager {
    var teamsWithHat1: [SoccerTeam] {
        return teamsData.filter({ $0.hat == 1 && $0.playoff == "" })
    }

    var teamsWithHat2: [SoccerTeam] {
        return teamsData.filter({ $0.hat == 2 && $0.playoff == "" })
    }

    var teamsWithHat3: [SoccerTeam] {
        return teamsData.filter({ $0.hat == 3 && $0.playoff == "" })
    }

    var teamsWithHat4: [SoccerTeam] {
        let teamsOf3WithPayOff = teamsWithPlayoff.shuffled().suffix(3)
        return teamsData.filter({ $0.hat == 4 && $0.playoff == "" }) + teamsOf3WithPayOff
    }
    
    var teamsWithPlayoff: [SoccerTeam] {
        return teamsData.filter({ $0.playoff != "" })
    }
}

extension TeamManager {
    
    func createGroups() {
        var groups = [GroupTeam]()
        
        var teamsHat1 = teamsWithHat1.shuffled()
        var teamsHat2 = teamsWithHat2.shuffled()
        var teamsHat3 = teamsWithHat3.shuffled()
        var teamsHat4 = teamsWithHat4.shuffled()

        let groupLetters = ["A", "B", "C", "D", "E", "F"]
        
        for letter in groupLetters {
            // Sélection d'une équipe aléatoire de chaque chapeau pour le groupe actuel
            let team1 = teamsHat1.removeFirst()
            let team2 = teamsHat2.removeFirst()
            let team3 = teamsHat3.removeFirst()
            let team4 = teamsHat4.removeFirst()
            
            // Stockage des équipes dans le groupe
            let group = GroupTeam(title: letter, teams: [team1, team2, team3, team4])
            groups.append(group)
        }
            
        self.groups = groups
    }
    
}
