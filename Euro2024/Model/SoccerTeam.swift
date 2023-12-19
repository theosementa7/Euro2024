//
//  SoccerTeam.swift
//  Euro2024
//
//  Created by KaayZenn on 19/12/2023.
//

import SwiftUI

struct SoccerTeam {
    let name: String
    let primaryColor: Color
    let secondaryColor: Color
    let fifaRanking: Int
    let code: String
    let hat: Int
    let playoff: String
}

let teamsData = [
    SoccerTeam(name: "Italy", primaryColor: Color(hex: "#3399FF"), secondaryColor: Color(hex: "#FFFFFF"), fifaRanking: 9, code: "it", hat: 4, playoff: ""),
    SoccerTeam(name: "Germany", primaryColor: Color(hex: "#FFFFFF"), secondaryColor: Color(hex: "#18222F"), fifaRanking: 16, code: "de", hat: 1, playoff: ""),
    SoccerTeam(name: "Portugal", primaryColor: Color(hex: "#E35169"), secondaryColor: Color(hex: "#2ECDA7"), fifaRanking: 6, code: "pt", hat: 1, playoff: ""),
    SoccerTeam(name: "Spain", primaryColor: Color(hex: "#E35169"), secondaryColor: Color(hex: "#FFC23B"), fifaRanking: 8, code: "es", hat: 1, playoff: ""),
    SoccerTeam(name: "Belgium", primaryColor: Color(hex: "#E35169"), secondaryColor: Color(hex: "#18222F"), fifaRanking: 5, code: "be", hat: 1, playoff: ""),
    SoccerTeam(name: "England", primaryColor: Color(hex: "#FFFFFF"), secondaryColor: Color(hex: "#E35169"), fifaRanking: 4, code: "gb-eng", hat: 1, playoff: ""),
    SoccerTeam(name: "Hungary", primaryColor: Color(hex: "#E35169"), secondaryColor: Color(hex: "#2ECDA7"), fifaRanking: 30, code: "hu", hat: 2, playoff: ""),
    SoccerTeam(name: "Turkey", primaryColor: Color(hex: "#E35169"), secondaryColor: Color(hex: "#FFFFFF"), fifaRanking: 38, code: "tr", hat: 2, playoff: ""),
    SoccerTeam(name: "Romania", primaryColor: Color(hex: "#FFC23B"), secondaryColor: Color(hex: "#005FFF"), fifaRanking: 48, code: "ro", hat: 2, playoff: ""),
    SoccerTeam(name: "Denmark", primaryColor: Color(hex: "#E35169"), secondaryColor: Color(hex: "#FFFFFF"), fifaRanking: 19, code: "dk", hat: 2, playoff: ""),
    SoccerTeam(name: "Albania", primaryColor: Color(hex: "#E35169"), secondaryColor: Color(hex: "#18222F"), fifaRanking: 59, code: "al", hat: 2, playoff: ""),
    SoccerTeam(name: "Austria", primaryColor: Color(hex: "#FFFFFF"), secondaryColor: Color(hex: "#18222F"), fifaRanking: 25, code: "at", hat: 2, playoff: ""),
    SoccerTeam(name: "Netherlands", primaryColor: Color(hex: "#FFA439"), secondaryColor: Color(hex: "#FFFFFF"), fifaRanking: 7, code: "nl", hat: 3, playoff: ""),
    SoccerTeam(name: "Scotland", primaryColor: Color(hex: "#000080"), secondaryColor: Color(hex: "#FFFFFF"), fifaRanking: 34, code: "gb-sct", hat: 3, playoff: ""),
    SoccerTeam(name: "Croatia", primaryColor: Color(hex: "#FFFFFF"), secondaryColor: Color(hex: "#E35169"), fifaRanking: 10, code: "hr", hat: 3, playoff: ""),
    SoccerTeam(name: "Slovenia", primaryColor: Color(hex: "#FFFFFF"), secondaryColor: Color(hex: "#E35169"), fifaRanking: 54, code: "si", hat: 3, playoff: ""),
    SoccerTeam(name: "Slovakia", primaryColor: Color(hex: "#FFFFFF"), secondaryColor: Color(hex: "#E35169"), fifaRanking: 50, code: "sk", hat: 3, playoff: ""),
    SoccerTeam(name: "Czech", primaryColor: Color(hex: "#E35169"), secondaryColor: Color(hex: "#0051FF"), fifaRanking: 41, code: "cz", hat: 3, playoff: ""),
    SoccerTeam(name: "Serbia", primaryColor: Color(hex: "#E35169"), secondaryColor: Color(hex: "#0026FF"), fifaRanking: 29, code: "rs", hat: 4, playoff: ""),
    SoccerTeam(name: "Switzerland", primaryColor: Color(hex: "#E35169"), secondaryColor: Color(hex: "#FFFFFF"), fifaRanking: 14, code: "ch", hat: 4, playoff: ""),
    SoccerTeam(name: "Wales", primaryColor: Color(hex: "#FFFFFF"), secondaryColor: Color(hex: "#09BB75"), fifaRanking: 28, code: "gb-wls", hat: 4, playoff: "A"),
    SoccerTeam(name: "Finland", primaryColor: Color(hex: "#FFFFFF"), secondaryColor: Color(hex: "#3399FF"), fifaRanking: 62, code: "fi", hat: 4, playoff: "A"),
    SoccerTeam(name: "Poland", primaryColor: Color(hex: "#FFFFFF"), secondaryColor: Color(hex: "#E35169"), fifaRanking: 31, code: "pl", hat: 4, playoff: "A"),
    SoccerTeam(name: "Estonia", primaryColor: Color(hex: "#FFFFFF"), secondaryColor: Color(hex: "#3399FF"), fifaRanking: 118, code: "ee", hat: 4, playoff: "A"),
    SoccerTeam(name: "Bosnia Herzegovina", primaryColor: Color(hex: "#FFC23B"), secondaryColor: Color(hex: "#3399FF"), fifaRanking: 63, code: "ba", hat: 4, playoff: "B"),
    SoccerTeam(name: "Ukraine", primaryColor: Color(hex: "#FFC23B"), secondaryColor: Color(hex: "#3399FF"), fifaRanking: 22, code: "ua", hat: 4, playoff: "B"),
    SoccerTeam(name: "Israël", primaryColor: Color(hex: "#FFFFFF"), secondaryColor: Color(hex: "#3399FF"), fifaRanking: 71, code: "il", hat: 4, playoff: "B"),
    SoccerTeam(name: "Island", primaryColor: Color(hex: "#272CFF"), secondaryColor: Color(hex: "#E35169"), fifaRanking: 67, code: "is", hat: 4, playoff: "B"),
    SoccerTeam(name: "Georgia", primaryColor: Color(hex: "#FFFFFF"), secondaryColor: Color(hex: "#E35169"), fifaRanking: 76, code: "ge", hat: 4, playoff: "C"),
    SoccerTeam(name: "Luxembourg", primaryColor: Color(hex: "#E35169"), secondaryColor: Color(hex: "#3399FF"), fifaRanking: 87, code: "lu", hat: 4, playoff: "C"),
    SoccerTeam(name: "Greece", primaryColor: Color(hex: "#3399FF"), secondaryColor: Color(hex: "#FFFFFF"), fifaRanking: 51, code: "gr", hat: 4, playoff: "C"),
    SoccerTeam(name: "Kazakhstan", primaryColor: Color(hex: "#FFC23B"), secondaryColor: Color(hex: "#3399FF"), fifaRanking: 98, code: "kz", hat: 4, playoff: "C"),
    SoccerTeam(name: "France", primaryColor: Color(hex: "#0000BA"), secondaryColor: Color(hex: "#E35169"), fifaRanking: 2, code: "fr", hat: 1, playoff: "")
]
