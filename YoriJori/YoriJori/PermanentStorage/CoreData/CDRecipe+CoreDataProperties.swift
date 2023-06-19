//
//  CDRecipe+CoreDataProperties.swift
//  YoriJori
//
//  Created by Moon Yeji on 2023/06/19.
//
//

import Foundation
import CoreData


extension CDRecipe {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDRecipe> {
        return NSFetchRequest<CDRecipe>(entityName: "CDRecipe")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var subTitle: String?
    @NSManaged public var cookingTime: Int64
    @NSManaged public var descriptions: String?
    @NSManaged public var note: String?
    @NSManaged public var serving: Int64
    @NSManaged public var image: Data?
    @NSManaged public var createdAt: Date?
    @NSManaged public var updatedAt: Date?
    @NSManaged public var ingredientGroups: NSSet?
    @NSManaged public var tags: CDTag?
    @NSManaged public var progress: CDProgress?

}

// MARK: Generated accessors for ingredientGroups
extension CDRecipe {

    @objc(addIngredientGroupsObject:)
    @NSManaged public func addToIngredientGroups(_ value: CDIngredientGroup)

    @objc(removeIngredientGroupsObject:)
    @NSManaged public func removeFromIngredientGroups(_ value: CDIngredientGroup)

    @objc(addIngredientGroups:)
    @NSManaged public func addToIngredientGroups(_ values: NSSet)

    @objc(removeIngredientGroups:)
    @NSManaged public func removeFromIngredientGroups(_ values: NSSet)

}

extension CDRecipe : Identifiable {

}
