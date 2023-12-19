//
//  MatchEntity+CoreDataProperties.swift
//  Euro2024
//
//  Created by KaayZenn on 19/12/2023.
//
//

import Foundation
import CoreData

@objc(MatchEntity)
public class MatchEntity: NSManagedObject, Identifiable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MatchEntity> {
        return NSFetchRequest<MatchEntity>(entityName: "MatchEntity")
    }

    @NSManaged public var id: UUID
    @NSManaged public var scoreTeamOne: Int16
    @NSManaged public var scoreTeamTwo: Int16
    @NSManaged public var teamOne: TeamEntity
    @NSManaged public var teamTwo: TeamEntity
    @NSManaged public var matchToGroup: GroupEntity

}

