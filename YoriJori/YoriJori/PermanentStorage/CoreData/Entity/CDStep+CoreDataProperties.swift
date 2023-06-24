//
//  CDStep+CoreDataProperties.swift
//  YoriJori
//
//  Created by Moon Yeji on 2023/06/19.
//
//

import Foundation
import CoreData


extension CDStep {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDStep> {
        return NSFetchRequest<CDStep>(entityName: "CDStep")
    }

    @NSManaged public var index: Int64
    @NSManaged public var descriptions: String?
    @NSManaged public var image: Data?
    @NSManaged public var time: Int64
    @NSManaged public var ingredients: NSSet?

}

// MARK: Generated accessors for ingredients
extension CDStep {

    @objc(addIngredientsObject:)
    @NSManaged public func addToIngredients(_ value: CDIngredient)

    @objc(removeIngredientsObject:)
    @NSManaged public func removeFromIngredients(_ value: CDIngredient)

    @objc(addIngredients:)
    @NSManaged public func addToIngredients(_ values: NSSet)

    @objc(removeIngredients:)
    @NSManaged public func removeFromIngredients(_ values: NSSet)

}

extension CDStep : Identifiable {

}
