//
//  DefaultRecipeStorage.swift
//  YoriJori
//
//  Created by forest on 2023/06/25.
//

import CoreData
import Foundation

final class RecipeRepository: RecipeRepositoryProtocol {
    
    let coreDataProvider: CoreDataProvider
    
    init(coreDataProvider: CoreDataProvider) {
        self.coreDataProvider = coreDataProvider
    }
    
    func fetchAllRecipes() throws -> [Recipe] {
        let request = CDRecipe.fetchRequest()
        let result = try coreDataProvider.fetch(request: request)
        
        return result.map { $0.toDomain() }
    }
    
    func fetchRecipes(by title: String) throws -> [Recipe] {
        let request = CDRecipe.fetchRequest()
        let predicate = NSPredicate(format: "title contains[cd] %@", title)
        
        let result = try coreDataProvider.fetch(
            request: request,
            predicate: predicate)
        
        return result.map { $0.toDomain() }
    }
    
    func fetchRecipes(by bookdId: UUID) throws -> [Recipe] {
        let request = CDRecipeBook.fetchRequest()
        let predicate = NSPredicate(format: "id == %@", bookdId as CVarArg)
        
        let fetchedRecipeBooks = try coreDataProvider.fetch(
            request: request,
            predicate: predicate)
        
        guard let recipes = fetchedRecipeBooks.first?.recipes as? [CDRecipe] else {
            return  []
        }
        
        return recipes.map { $0.toDomain() }
    }
    
    func fetchRecipes(by tag: Tag) throws -> [Recipe] {
        let request = CDRecipe.fetchRequest()
        guard let tagEntity = try? tag.toEntity(context: coreDataProvider.context) else {
            return []
        }
        let predicate = NSPredicate(format: "tags.name contains[cd] %@", tag.name as CVarArg)
        
        let result = try coreDataProvider.fetch(request: request, predicate: predicate)
        
        return result.map { $0.toDomain() }
    }
   
    func fetchRecipes(by grocery: Grocery) throws -> [Recipe] {
        let request = CDRecipe.fetchRequest()
        guard let groceryEntity = try? grocery.toEntity(context: coreDataProvider.context) else {
            return []
        }
        let predicate = NSPredicate(
            format: "ingredientGroups.ingredients.grocery.name contains[cd] %@",
            grocery.name as CVarArg)
        
        let result = try coreDataProvider.fetch(request: request, predicate: predicate)
        
        return result.map { $0.toDomain() }
    }
    
    func createRecipe(_ model: Recipe) throws {
        let recipe = CDRecipe(context: self.coreDataProvider.context)
        recipe.id = model.id
        recipe.title = model.title
        recipe.subTitle = model.subTitle
        recipe.cookingTime = Int64(model.cookingTime ?? -1)
        recipe.descriptions = model.description
        recipe.note = model.note
        recipe.serving = Int64(model.serving ?? -1)
        recipe.image = model.image
        recipe.createdAt = model.createdAt
        recipe.updatedAt = model.updatedAt
        recipe.addToTags(
            NSSet(
                array: model.tags?.map {
                    try! $0.toEntity(context: coreDataProvider.context) } ?? [])
        )
        recipe.addToIngredientGroups(
            NSSet(
                array: model.ingredientsGroups?.map {
                    $0.toEntity(context: coreDataProvider.context) } ?? [])
        )
        recipe.addToProgress(
            NSSet(
                array: model.progress?.map {
                    $0.toEntity(context: coreDataProvider.context) } ?? [])
        )
        
        try? self.coreDataProvider.context.save()
    }

    func updateRecipe(_ recipe: Recipe) throws {
        let request = CDRecipe.fetchRequest()
        let predicate = NSPredicate(format: "id == %@", recipe.id as CVarArg)
        guard let recipeEntity = try? coreDataProvider.fetch(
            request: request,
            predicate: predicate)
            .first else {
            return
        }
        
        recipeEntity.title = recipe.title
        recipeEntity.subTitle = recipe.subTitle
        recipeEntity.tags = NSSet(
            array: recipe.tags?.compactMap {
                try! $0.toEntity(context: coreDataProvider.context) } ?? []
        )
        recipeEntity.ingredientGroups = NSSet(
            array: recipe.ingredientsGroups?.compactMap {
                $0.toEntity(context: coreDataProvider.context) } ?? []
        )
        recipeEntity.cookingTime = Int64(recipe.cookingTime ?? -1)
        recipeEntity.progress = NSSet(
            array: recipe.progress?.compactMap {
                $0.toEntity(context: coreDataProvider.context) } ?? []
        )
        recipeEntity.descriptions = recipe.description
        recipeEntity.note = recipe.note
        recipeEntity.serving = Int64(recipe.serving ?? -1)
        recipeEntity.image = recipe.image
        recipeEntity.updatedAt = recipe.updatedAt
        
        try self.coreDataProvider.context.save()
    }
    
    func deleteRecipe(_ recipe: Recipe) throws {
        let request = CDRecipe.fetchRequest()
        let predicate = NSPredicate(format: "id == %@", recipe.id as CVarArg)
        guard let recipeEntity = try? coreDataProvider.fetch(
            request: request,
            predicate: predicate).first else {
            return
        }
        
        try self.coreDataProvider.delete(object: recipeEntity)
    }
}
