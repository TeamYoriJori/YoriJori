//
//  CDIngredientGroup+CoreDataProperties.swift
//  YoriJori
//
//  Created by Moon Yeji on 2023/06/19.
//
//

import Foundation
import CoreData


extension CDIngredientGroup {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDIngredientGroup> {
        return NSFetchRequest<CDIngredientGroup>(entityName: "CDIngredientGroup")
    }

    @NSManaged public var title: String?
    @NSManaged public var ingredients: NSSet?
    @NSManaged public var recipe: CDRecipe?

}

// MARK: Generated accessors for ingredients
extension CDIngredientGroup {

    @objc(addIngredientsObject:)
    @NSManaged public func addToIngredients(_ value: CDIngredient)

    @objc(removeIngredientsObject:)
    @NSManaged public func removeFromIngredients(_ value: CDIngredient)

    @objc(addIngredients:)
    @NSManaged public func addToIngredients(_ values: NSSet)

    @objc(removeIngredients:)
    @NSManaged public func removeFromIngredients(_ values: NSSet)

}

extension CDIngredientGroup : Identifiable {

}
