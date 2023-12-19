//
//  GroupTeam.swift
//  Euro2024
//
//  Created by KaayZenn on 19/12/2023.
//

import Foundation

struct GroupTeam: Identifiable {
    var id: UUID = UUID()
    var title: String
    var teams: [SoccerTeam]
}
