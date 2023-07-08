//
//  CDIngredient+CoreDataProperties.swift
//  YoriJori
//
//  Created by Moon Yeji on 2023/06/19.
//
//

import Foundation
import CoreData


extension CDIngredient {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDIngredient> {
        return NSFetchRequest<CDIngredient>(entityName: "CDIngredient")
    }

    @NSManaged public var title: String?
    @NSManaged public var amount: Double
    @NSManaged public var unit: String?

}

extension CDIngredient : Identifiable {

}

extension CDIngredient {
    func toDomain() -> Ingredient? {
        
        guard let unitString = self.unit,
              let unit = Unit(rawValue: unitString) else {
            return Ingredient(title: self.title, amount: self.amount , unit: .none)
        }
        return Ingredient(title: self.title, amount: self.amount , unit: unit)
    }
}
