//
//  CDGrocery+CoreDataProperties.swift
//  YoriJori
//
//  Created by Moon Yeji on 2023/06/25.
//
//

import CoreData
import Foundation

extension CDGrocery {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDGrocery> {
        return NSFetchRequest<CDGrocery>(entityName: "CDGrocery")
    }

    @NSManaged public var name: String
    @NSManaged public var ingredients: NSSet?
    @NSManaged public var steps: NSSet?

}

// MARK: Generated accessors for ingredients
extension CDGrocery {

    @objc(addIngredientsObject:)
    @NSManaged public func addToIngredients(_ value: CDIngredient)

    @objc(removeIngredientsObject:)
    @NSManaged public func removeFromIngredients(_ value: CDIngredient)

    @objc(addIngredients:)
    @NSManaged public func addToIngredients(_ values: NSSet)

    @objc(removeIngredients:)
    @NSManaged public func removeFromIngredients(_ values: NSSet)

}

// MARK: Generated accessors for steps
extension CDGrocery {

    @objc(addStepsObject:)
    @NSManaged public func addToSteps(_ value: CDStep)

    @objc(removeStepsObject:)
    @NSManaged public func removeFromSteps(_ value: CDStep)

    @objc(addSteps:)
    @NSManaged public func addToSteps(_ values: NSSet)

    @objc(removeSteps:)
    @NSManaged public func removeFromSteps(_ values: NSSet)

}

extension CDGrocery : Identifiable {

}
