//
//  IngredientGroup+DTO.swift
//  YoriJori
//
//  Created by Moon Yeji on 2023/07/08.
//

import CoreData
import Foundation

extension CDIngredientGroup {
    func toDomain() -> IngreidentGroup {
        return IngreidentGroup(
            title: self.title,
            ingredients: self.ingredients?
                .compactMap { $0 as? CDIngredient }
                .compactMap { $0.toDomain() }
        )
    }
}

extension IngreidentGroup {
    func toEntity(coreDataProvider: CoreDataProvider) -> CDIngredientGroup {
        let ingredientGroup = CDIngredientGroup(context: coreDataProvider.context)
        ingredientGroup.title = self.title
        ingredientGroup.ingredients = NSSet(
            array: self.ingredients?.compactMap { $0.toEntity(coreDataProvider: coreDataProvider) } ?? [])
        return ingredientGroup
    }
}
