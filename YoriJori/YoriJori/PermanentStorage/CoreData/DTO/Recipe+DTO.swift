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
            recipeBookID: self.recipeBook?.id,
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
        let request = CDRecipe.fetchRequest()
        let predicate = NSPredicate(format: "id == %@", self.id as CVarArg)
        if let fetchedRecipe = try? coreDataProvider.fetch(
            request: request,
            predicate: predicate,
            sortDiscriptors: nil).first {
                return fetchedRecipe
            }

        let recipe = CDRecipe(context: coreDataProvider.context)
        recipe.id = self.id
        recipe.recipeBookID = self.recipeBookID
        recipe.title = self.title
        recipe.subTitle = self.subTitle
        recipe.cookingTime = Int64(self.cookingTime ?? -1)
        recipe.descriptions = self.description
        recipe.note = self.note
        recipe.serving = Int64(self.serving ?? -1)
        recipe.image = self.image
        recipe.createdAt = self.createdAt
        recipe.updatedAt = self.updatedAt
        recipe.tags = NSSet(
            array: self.tags?.compactMap { try! $0.toEntity(coreDataProvider: coreDataProvider) } ?? [])
        recipe.ingredientGroups = NSSet(
            array: self.ingredientsGroups?.compactMap { $0.toEntity(coreDataProvider: coreDataProvider) } ?? [])
        recipe.progress =  NSSet(
            array: self.progress?.compactMap { $0.toEntity(coreDataProvider: coreDataProvider) } ?? [])
        return recipe
    }
}
