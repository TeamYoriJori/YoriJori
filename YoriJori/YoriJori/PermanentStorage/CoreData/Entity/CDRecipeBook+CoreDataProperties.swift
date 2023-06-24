//
//  CDRecipeBook+CoreDataProperties.swift
//  YoriJori
//
//  Created by Moon Yeji on 2023/06/24.
//
//

import Foundation
import CoreData


extension CDRecipeBook {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDRecipeBook> {
        return NSFetchRequest<CDRecipeBook>(entityName: "CDRecipeBook")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var image: Data?
    @NSManaged public var title: String?
    @NSManaged public var recipes: NSSet?

}

// MARK: Generated accessors for recipes
extension CDRecipeBook {

    @objc(addRecipesObject:)
    @NSManaged public func addToRecipes(_ value: CDRecipe)

    @objc(removeRecipesObject:)
    @NSManaged public func removeFromRecipes(_ value: CDRecipe)

    @objc(addRecipes:)
    @NSManaged public func addToRecipes(_ values: NSSet)

    @objc(removeRecipes:)
    @NSManaged public func removeFromRecipes(_ values: NSSet)

}

extension CDRecipeBook : Identifiable {

}
