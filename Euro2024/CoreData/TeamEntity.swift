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
    @NSManaged public var teamToGroup: GroupEntity?

}
