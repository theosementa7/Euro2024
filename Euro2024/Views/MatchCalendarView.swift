//
//  MatchCalendarView.swift
//  Euro2024
//
//  Created by KaayZenn on 19/12/2023.
//

import SwiftUI

struct MatchCalendarView: View {
    
    var mainTeam: SoccerTeam
    var group: GroupTeam
    
    var body: some View {
        Form {
            ForEach(group.teams.filter({ $0.id != mainTeam.id })) { team in
                HStack {
                    Text(mainTeam.name + " - " + team.name)
                    Spacer()
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    MatchCalendarView(
        mainTeam: teamsData[1],
        group: GroupTeam(
            title: "A",
            teams: [
                teamsData[1],
                teamsData[2],
                teamsData[3]
            ]
        )
    )
}
