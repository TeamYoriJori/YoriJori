//
//  CDProgress+CoreDataProperties.swift
//  YoriJori
//
//  Created by Moon Yeji on 2023/06/19.
//
//

import Foundation
import CoreData


extension CDProgress {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDProgress> {
        return NSFetchRequest<CDProgress>(entityName: "CDProgress")
    }

    @NSManaged public var steps: NSSet?

}

// MARK: Generated accessors for steps
extension CDProgress {

    @objc(addStepsObject:)
    @NSManaged public func addToSteps(_ value: CDStep)

    @objc(removeStepsObject:)
    @NSManaged public func removeFromSteps(_ value: CDStep)

    @objc(addSteps:)
    @NSManaged public func addToSteps(_ values: NSSet)

    @objc(removeSteps:)
    @NSManaged public func removeFromSteps(_ values: NSSet)

}

extension CDProgress : Identifiable {

}
