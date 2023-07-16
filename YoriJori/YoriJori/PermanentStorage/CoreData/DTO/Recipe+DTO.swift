//
//  Recipe+DTO.swift
//  YoriJori
//
//  Created by Moon Yeji on 2023/07/08.
//

import CoreData
import Foundation

extension CDRecipe {
    func toDomain() -> Recipe {
        Recipe(
            id: self.id,
            title: self.title,
            subTitle: self.subTitle,
            tags: self.tags?.compactMap { $0 as? CDTag }.compactMap { $0.toDomain() },
            ingredientsGroups: self.ingredientGroups?.compactMap { $0 as? CDIngredientGroup }
                .compactMap { $0.toDomain() },
            cookingTime: Int(self.cookingTime),
            progress: self.progress?.compactMap { $0 as? CDStep }.map { $0.toDomain() },
            description: self.descriptions,
            note: self.note,
            serving: Int(self.serving),
            image: self.image,
            createdAt: self.createdAt,
            updatedAt: self.updatedAt
        )
    }
}

extension Recipe {
    func toEntity(coreDataProvider: CoreDataProvider) -> CDRecipe {
        let recipe = CDRecipe(context: coreDataProvider.context)
        recipe.id = self.id
        recipe.title = self.title
        recipe.subTitle = self.subTitle
        recipe.tags = NSSet(
            array: self.tags?.compactMap { try! $0.toEntity(coreDataProvider: coreDataProvider) } ?? [])
        return recipe
    }
}
