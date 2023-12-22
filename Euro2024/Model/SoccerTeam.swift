//
//  SoccerTeam.swift
//  Euro2024
//
//  Created by KaayZenn on 19/12/2023.
//

import Foundation

struct SoccerTeam {
    let name: String
    let primaryColor: String
    let secondaryColor: String
    let fifaRanking: Int
    let code: String
    let hat: Int
    let playoff: String
}

let teamsData = [
    SoccerTeam(name: "Italy", primaryColor: "#3399FF", secondaryColor: "#FFFFFF", fifaRanking: 9, code: "it", hat: 4, playoff: ""),
    SoccerTeam(name: "Germany", primaryColor: "#FFFFFF", secondaryColor: "#18222F", fifaRanking: 16, code: "de", hat: 1, playoff: ""),
    SoccerTeam(name: "Portugal", primaryColor: "#E35169", secondaryColor: "#2ECDA7", fifaRanking: 6, code: "pt", hat: 1, playoff: ""),
    SoccerTeam(name: "Spain", primaryColor: "#E35169", secondaryColor: "#FFC23B", fifaRanking: 8, code: "es", hat: 1, playoff: ""),
    SoccerTeam(name: "Belgium", primaryColor: "#E35169", secondaryColor: "#18222F", fifaRanking: 5, code: "be", hat: 1, playoff: ""),
    SoccerTeam(name: "England", primaryColor: "#FFFFFF", secondaryColor: "#E35169", fifaRanking: 4, code: "gb-eng", hat: 1, playoff: ""),
    SoccerTeam(name: "Hungary", primaryColor: "#E35169", secondaryColor: "#2ECDA7", fifaRanking: 30, code: "hu", hat: 2, playoff: ""),
    SoccerTeam(name: "Turkey", primaryColor: "#E35169", secondaryColor: "#FFFFFF", fifaRanking: 38, code: "tr", hat: 2, playoff: ""),
    SoccerTeam(name: "Romania", primaryColor: "#FFC23B", secondaryColor: "#005FFF", fifaRanking: 48, code: "ro", hat: 2, playoff: ""),
    SoccerTeam(name: "Denmark", primaryColor: "#E35169", secondaryColor: "#FFFFFF", fifaRanking: 19, code: "dk", hat: 2, playoff: ""),
    SoccerTeam(name: "Albania", primaryColor: "#E35169", secondaryColor: "#18222F", fifaRanking: 59, code: "al", hat: 2, playoff: ""),
    SoccerTeam(name: "Austria", primaryColor: "#FFFFFF", secondaryColor: "#18222F", fifaRanking: 25, code: "at", hat: 2, playoff: ""),
    SoccerTeam(name: "Netherlands", primaryColor: "#FFA439", secondaryColor: "#FFFFFF", fifaRanking: 7, code: "nl", hat: 3, playoff: ""),
    SoccerTeam(name: "Scotland", primaryColor: "#000080", secondaryColor: "#FFFFFF", fifaRanking: 34, code: "gb-sct", hat: 3, playoff: ""),
    SoccerTeam(name: "Croatia", primaryColor: "#FFFFFF", secondaryColor: "#E35169", fifaRanking: 10, code: "hr", hat: 3, playoff: ""),
    SoccerTeam(name: "Slovenia", primaryColor: "#FFFFFF", secondaryColor: "#E35169", fifaRanking: 54, code: "si", hat: 3, playoff: ""),
    SoccerTeam(name: "Slovakia", primaryColor: "#FFFFFF", secondaryColor: "#E35169", fifaRanking: 50, code: "sk", hat: 3, playoff: ""),
    SoccerTeam(name: "Czech", primaryColor: "#E35169", secondaryColor: "#0051FF", fifaRanking: 41, code: "cz", hat: 3, playoff: ""),
    SoccerTeam(name: "Serbia", primaryColor: "#E35169", secondaryColor: "#0026FF", fifaRanking: 29, code: "rs", hat: 4, playoff: ""),
    SoccerTeam(name: "Switzerland", primaryColor: "#E35169", secondaryColor: "#FFFFFF", fifaRanking: 14, code: "ch", hat: 4, playoff: ""),
    SoccerTeam(name: "Wales", primaryColor: "#FFFFFF", secondaryColor: "#09BB75", fifaRanking: 28, code: "gb-wls", hat: 4, playoff: "A"),
    SoccerTeam(name: "Finland", primaryColor: "#FFFFFF", secondaryColor: "#3399FF", fifaRanking: 62, code: "fi", hat: 4, playoff: "A"),
    SoccerTeam(name: "Poland", primaryColor: "#FFFFFF", secondaryColor: "#E35169", fifaRanking: 31, code: "pl", hat: 4, playoff: "A"),
    SoccerTeam(name: "Estonia", primaryColor: "#FFFFFF", secondaryColor: "#3399FF", fifaRanking: 118, code: "ee", hat: 4, playoff: "A"),
    SoccerTeam(name: "Bosnia Herzegovina", primaryColor: "#FFC23B", secondaryColor: "#3399FF", fifaRanking: 63, code: "ba", hat: 4, playoff: "B"),
    SoccerTeam(name: "Ukraine", primaryColor: "#FFC23B", secondaryColor: "#3399FF", fifaRanking: 22, code: "ua", hat: 4, playoff: "B"),
    SoccerTeam(name: "Israël", primaryColor: "#FFFFFF", secondaryColor: "#3399FF", fifaRanking: 71, code: "il", hat: 4, playoff: "B"),
    SoccerTeam(name: "Island", primaryColor: "#272CFF", secondaryColor: "#E35169", fifaRanking: 67, code: "is", hat: 4, playoff: "B"),
    SoccerTeam(name: "Georgia", primaryColor: "#FFFFFF", secondaryColor: "#E35169", fifaRanking: 76, code: "ge", hat: 4, playoff: "C"),
    SoccerTeam(name: "Luxembourg", primaryColor: "#E35169", secondaryColor: "#3399FF", fifaRanking: 87, code: "lu", hat: 4, playoff: "C"),
    SoccerTeam(name: "Greece", primaryColor: "#3399FF", secondaryColor: "#FFFFFF", fifaRanking: 51, code: "gr", hat: 4, playoff: "C"),
    SoccerTeam(name: "Kazakhstan", primaryColor: "#FFC23B", secondaryColor: "#3399FF", fifaRanking: 98, code: "kz", hat: 4, playoff: "C"),
    SoccerTeam(name: "France", primaryColor: "#0000BA", secondaryColor: "#E35169", fifaRanking: 2, code: "fr", hat: 1, playoff: "")
]
