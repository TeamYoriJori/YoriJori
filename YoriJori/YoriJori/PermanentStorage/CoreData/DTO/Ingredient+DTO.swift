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
            return Ingredient(grocery: self.grocery.toDomain(), amount: self.amount, unit: Unit.none)
        }
        return Ingredient(grocery: self.grocery.toDomain(), amount: self.amount , unit: unit)
    }
}

extension Ingredient {
    func toEntity(coreDataProvider: CoreDataProvider) -> CDIngredient {
        let ingredient = CDIngredient(context: coreDataProvider.context)
        
        let groceryFetchRequest = CDGrocery.fetchRequest()
        groceryFetchRequest.predicate = NSPredicate(format: "name == %@", self.grocery.name)
        if let grocery = try? coreDataProvider.fetch(request: groceryFetchRequest).first {
            ingredient.grocery = grocery
        } else {
            let grocery = CDGrocery(context: coreDataProvider.context)
            grocery.name = self.grocery.name
            ingredient.grocery = grocery
        }
        
        ingredient.amount = Double(self.amount ?? -1)
        ingredient.unit = self.unit?.rawValue
        return ingredient
    }
}
