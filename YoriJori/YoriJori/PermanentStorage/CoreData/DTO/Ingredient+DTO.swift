//
//  Ingredient+DTO.swift
//  YoriJori
//
//  Created by Moon Yeji on 2023/07/08.
//

import CoreData
import Foundation

extension CDIngredient {
    func toDomain() -> Ingredient? {
        guard let unitString = self.unit,
              let unit = Unit(rawValue: unitString) else {
            return Ingredient(title: self.title, amount: self.amount , unit: .none)
        }
        return Ingredient(title: self.title, amount: self.amount , unit: unit)
    }
}

extension Ingredient {
    func toEntity(context: NSManagedObjectContext) -> CDIngredient {
        let ingredient = CDIngredient(context: context)
        ingredient.title = self.title
        ingredient.amount = Double(self.amount ?? -1)
        ingredient.unit = self.unit.rawValue
        return ingredient
    }
}
