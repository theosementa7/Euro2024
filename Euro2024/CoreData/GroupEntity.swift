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

    public var teams: [TeamEntity] {
        if let groupToTeam {
            return Array(groupToTeam)
        } else { return [] }
    }
}
