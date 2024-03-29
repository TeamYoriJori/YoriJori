//
//  RecipeBook+DTO.swift
//  YoriJori
//
//  Created by Moon Yeji on 2023/07/08.
//

import CoreData
import Foundation

extension CDRecipeBook {
    func toDomain() -> RecipeBook {
        let recipeEntities = self.recipes?.allObjects as? [CDRecipe]
        return RecipeBook(
            id: self.id ?? UUID(),
            title: self.title,
            image: self.image,
            updatedAt: self.updatedAt,
            recipes: recipeEntities?.map{ $0.toDomain() }
        )
    }
}

extension RecipeBook {
    func toEntity(coreDataProvider: CoreDataProvider) -> CDRecipeBook {
        let request = CDRecipeBook.fetchRequest()
        let predicate = NSPredicate(format: "id == %@", self.id as CVarArg)
        let fetchedRecipeBooks = try? coreDataProvider.fetch(request: request, predicate: predicate)

        if let fetchedRecipeBook = fetchedRecipeBooks?.first {
            return fetchedRecipeBook
        }
       
        let recipeBook = CDRecipeBook(context: coreDataProvider.context)
        recipeBook.id = self.id
        recipeBook.title = self.title
        recipeBook.image = self.image
        recipeBook.updatedAt = self.updatedAt
        recipeBook.recipes = NSSet(
            array: self.recipes?.compactMap { $0.toEntity(coreDataProvider: coreDataProvider) } ?? [])
        return recipeBook
    }
}
