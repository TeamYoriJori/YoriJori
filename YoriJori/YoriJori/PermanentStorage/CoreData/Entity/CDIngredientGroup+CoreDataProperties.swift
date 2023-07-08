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

extension CDIngredientGroup {
    func toDomain() -> IngreidentGroup {
        return IngreidentGroup(title: self.title, ingredients: self.ingredients?.compactMap { $0 as? CDIngredient }.compactMap { $0.toDomain() })
    }
}
