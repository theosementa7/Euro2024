//
//  GroupEntity+CoreDataProperties.swift
//  Euro2024
//
//  Created by KaayZenn on 19/12/2023.
//
//

import Foundation
import CoreData

@objc(GroupEntity)
public class GroupEntity: NSManagedObject, Identifiable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GroupEntity> {
        return NSFetchRequest<GroupEntity>(entityName: "GroupEntity")
    }

    @NSManaged public var id: UUID
    @NSManaged public var name: String
    @NSManaged public var groupToTeam: Set<TeamEntity>?
    @NSManaged public var groupToMatch: Set<MatchEntity>?

    public var teams: [TeamEntity] {
        if let groupToTeam {
            return Array(groupToTeam)
        } else { return [] }
    }
    
    public var matchs: [MatchEntity] {
        if let groupToMatch {
            return Array(groupToMatch)
        } else { return [] }
    }
}

extension GroupEntity {
    
    var matchForTeamOne: [MatchEntity] {
        return matchs.filter { $0.teamOne == teams.first }
    }
    
    var matchForTeamTwo: [MatchEntity] {
        if teams.count >= 2 {
            return matchs.filter { $0.teamOne == teams[1] || $0.teamTwo == teams[1] }
        } else { return [] }
    }
    
    var matchForTeamThree: [MatchEntity] {
        if teams.count >= 3 {
            return matchs.filter { $0.teamOne == teams[2] || $0.teamTwo == teams[2] }
        } else { return [] }
    }
    
    var matchForTeamFour: [MatchEntity] {
        if teams.count >= 4 {
            return matchs.filter { $0.teamOne == teams[3] || $0.teamTwo == teams[3] }
        } else { return [] }
    }
    
}
