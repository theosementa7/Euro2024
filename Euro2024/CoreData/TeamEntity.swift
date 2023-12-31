//
//  TeamEntity+CoreDataProperties.swift
//  Euro2024
//
//  Created by KaayZenn on 19/12/2023.
//
//

import Foundation
import CoreData

@objc(TeamEntity)
public class TeamEntity: NSManagedObject, Identifiable {
    let context = PersistenceController.shared.container.viewContext

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TeamEntity> {
        return NSFetchRequest<TeamEntity>(entityName: "TeamEntity")
    }

    @NSManaged public var id: UUID
    @NSManaged public var name: String
    @NSManaged public var primaryColor: String
    @NSManaged public var secondaryColor: String
    @NSManaged public var fifaRanking: Int16
    @NSManaged public var code: String
    @NSManaged public var hat: Int16
    @NSManaged public var playoff: String
    @NSManaged public var score: Int16
    @NSManaged public var isIn16: Bool
    @NSManaged public var isIn8: Bool
    @NSManaged public var isIn4: Bool
    @NSManaged public var isIn2: Bool
    @NSManaged public var isWinner: Bool
    @NSManaged public var teamToGroup: GroupEntity?
    
    public var matchs: [MatchEntity] {
        var allMatchs: [MatchEntity] = []
        let request: NSFetchRequest<MatchEntity> = MatchEntity.fetchRequest()
        
        do {
            allMatchs = try context.fetch(request)
        } catch {
            print("⚠️ \(error.localizedDescription)")
        }
        
        return allMatchs.filter({ $0.teamOne == self || $0.teamTwo == self })
    }
}

// MARK: STATS WIN/LOSE/NUL
extension TeamEntity {
    
    public var numberOfMatchWin: Int {
        var num: Int = 0
        for match in matchs {
            if let winner = match.winner {
                if winner == self {
                    num += 1
                } else {
                    // DEFEAT
                }
            } else {
                // NUL
            }
        }
        return num
    }
    
    public var numberOfMatchLose: Int {
        var num: Int = 0
        for match in matchs {
            if let winner = match.winner {
                if winner == self {
                    // WIN
                } else {
                    num += 1
                }
            } else {
                // NUL
            }
        }
        return num
    }
    
    public var numberOfMatchNul: Int {
        var num: Int = 0
        for match in matchs {
            if let winner = match.winner {
                if winner == self {
                    // WIN
                } else {
                    // DEFEAT
                }
            } else {
                num += 1
            }
        }
        return num
    }
    
}

// MARK: STATS GOAL
extension TeamEntity {
    
    func numberOfGoalScored() -> Int {
        var num: Int = 0
        for match in matchs {
            if match.teamOne == self {
                num += Int(match.scoreTeamOne)
            } else {
                num += Int(match.scoreTeamTwo)
            }
        }
        return num
    }
    
    
    func numberOfGoalConceded() -> Int {
        var num: Int = 0
        for match in matchs {
            if match.teamOne == self {
                num += Int(match.scoreTeamTwo)
            } else {
                num += Int(match.scoreTeamOne)
            }
        }
        return num
    }
    
    func goalDiff() -> Int {
        if numberOfGoalScored() > numberOfGoalConceded() {
            return numberOfGoalScored() - numberOfGoalConceded()
        } else {
            return numberOfGoalConceded() - numberOfGoalScored()
        }
    }
    
}

