//
//  MatchCalendarView.swift
//  Euro2024
//
//  Created by KaayZenn on 19/12/2023.
//

import SwiftUI

struct MatchCalendarView: View {
    
    @ObservedObject var vm = DataViewModel.shared
    
    var teamSelected: TeamEntity
    var group: GroupEntity
    
    var body: some View {
        List {
            Section(content: {
                ForEach(group.matchs.filter({ $0.teamOne == teamSelected || $0.teamTwo == teamSelected })) { match in
                    HStack {
                        Text(teamSelected.name + " - " + otherTeamWithScore(match: match).0.name)
                        Spacer()
                        Text(mainTeamGoal(match: match).formatted() + " - " + otherTeamWithScore(match: match).1.formatted())
                    }
                }
            }, header: {
                Text(teamSelected.name)
            })
            
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            vm.createMatchesForGroup(group: group, team: teamSelected)
        }
    }
    
    func otherTeamWithScore(match: MatchEntity) -> (TeamEntity, Int) {
        if match.teamOne == teamSelected {
            return (match.teamTwo, Int(match.scoreTeamTwo))
        } else {
            return (match.teamOne, Int(match.scoreTeamOne))
        }
    }
    
    func mainTeamGoal(match: MatchEntity) -> Int {
        if match.scoreTeamOne == otherTeamWithScore(match: match).1 {
            return Int(match.scoreTeamTwo)
        } else {
            return Int(match.scoreTeamOne)
        }
    }
    
}

//#Preview {
//    MatchCalendarView(
//        mainTeam: teamsData[1],
//        group: GroupTeam(
//            title: "A",
//            teams: [
//                teamsData[1],
//                teamsData[2],
//                teamsData[3]
//            ]
//        )
//    )
//}
