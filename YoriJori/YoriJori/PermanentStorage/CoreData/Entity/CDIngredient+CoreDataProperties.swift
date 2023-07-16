//
//  CDIngredient+CoreDataProperties.swift
//  YoriJori
//
//  Created by moon Lily on 2023/07/16.
//
//

import Foundation
import CoreData


extension CDIngredient {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDIngredient> {
        return NSFetchRequest<CDIngredient>(entityName: "CDIngredient")
    }

    @NSManaged public var amount: Double
    @NSManaged public var unit: String?
    @NSManaged public var grocery: CDGrocery
    @NSManaged public var ingredientGroup: CDIngredientGroup?

}

extension CDIngredient : Identifiable {

}
