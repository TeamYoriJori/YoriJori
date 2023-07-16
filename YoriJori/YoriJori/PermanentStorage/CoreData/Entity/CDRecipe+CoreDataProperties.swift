//
//  CDRecipe+CoreDataProperties.swift
//  YoriJori
//
//  Created by forest on 2023/07/08.
//
//

import Foundation
import CoreData


extension CDRecipe {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDRecipe> {
        return NSFetchRequest<CDRecipe>(entityName: "CDRecipe")
    }

    @NSManaged public var cookingTime: Int64
    @NSManaged public var createdAt: Date
    @NSManaged public var descriptions: String?
    @NSManaged public var id: UUID
    @NSManaged public var image: Data?
    @NSManaged public var note: String?
    @NSManaged public var serving: Int64
    @NSManaged public var subTitle: String?
    @NSManaged public var title: String?
    @NSManaged public var updatedAt: Date
    @NSManaged public var ingredientGroups: NSSet?
    @NSManaged public var progress: NSSet?
    @NSManaged public var tags: NSSet?

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

// MARK: Generated accessors for progress
extension CDRecipe {

    @objc(addProgressObject:)
    @NSManaged public func addToProgress(_ value: CDStep)

    @objc(removeProgressObject:)
    @NSManaged public func removeFromProgress(_ value: CDStep)

    @objc(addProgress:)
    @NSManaged public func addToProgress(_ values: NSSet)

    @objc(removeProgress:)
    @NSManaged public func removeFromProgress(_ values: NSSet)

}

// MARK: Generated accessors for tags
extension CDRecipe {

    @objc(addTagsObject:)
    @NSManaged public func addToTags(_ value: CDTag)

    @objc(removeTagsObject:)
    @NSManaged public func removeFromTags(_ value: CDTag)

    @objc(addTags:)
    @NSManaged public func addToTags(_ values: NSSet)

    @objc(removeTags:)
    @NSManaged public func removeFromTags(_ values: NSSet)

}

extension CDRecipe : Identifiable {

}
