//
//  DefaultRecipeStorage.swift
//  YoriJori
//
//  Created by forest on 2023/06/25.
//

import CoreData
import Foundation

final class DefaultRecipeRepository {
    
    let coreDataProvider: CoreDataProvider
    
    init(coreDataProvider: CoreDataProvider = CoreDataProvider.shared) {
        self.coreDataProvider = coreDataProvider
    }
    
    func fetchRecipeEntity(id: UUID) throws -> CDRecipe {
        let request = CDRecipe.fetchRequest()
        let predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        guard let result = try coreDataProvider.fetch(
            request: request,
            predicate: predicate).first else {
            throw RecipeRepositoryError.RecipeFetchError
        }
        
        return result
    }
    
    private func sort<T>(_ array: [T], with sortDescirptors: [RecipeSortDescriptor: Bool]) -> [T] {
        let array = NSMutableArray(array: array)
        let sortDescriptors = createSortDescriptor(with: sortDescirptors)
        guard let sortedArray = array.sortedArray(using: sortDescriptors) as? [T] else {
            return []
        }
        
        return sortedArray
    }
}

extension DefaultRecipeRepository: RecipeRepositoryProtocol {
    func fetchAllRecipes() throws -> [Recipe] {
        let request = CDRecipe.fetchRequest()
        let result = try coreDataProvider.fetch(request: request)
        
        return result.map { $0.toDomain() }
    }
    
    func fetchRecipeByID(_ id: UUID) throws -> Recipe? {
        return try fetchRecipeEntity(id: id).toDomain()
    }
    
    func fetchRecipesByTitle(_ title: String, sorts: [RecipeSortDescriptor: Bool]) throws -> [Recipe] {
        let request = CDRecipe.fetchRequest()
        let predicate = NSPredicate(format: "title contains[cd] %@", title)
        
        let result = try coreDataProvider.fetch(
            request: request,
            predicate: predicate,
            sortDiscriptors: createSortDescriptor(with: sorts)
        )
        
        return result.map { $0.toDomain() }
    }
    
    func fetchRecipesByKeyword(_ keyword: String, sorts: [RecipeSortDescriptor: Bool]) throws -> [Recipe] {
        let request = CDRecipe.fetchRequest()
        let titlePredicate = NSPredicate(format: "title contains[cd] %@", keyword)
        let tagPredicate = NSPredicate(format: "ANY tags.name == %@", keyword)
        let predicate = NSCompoundPredicate(
            type: .or,
            subpredicates: [titlePredicate, tagPredicate])
        let fetchedRecipesByTitleOrTag = try coreDataProvider.fetch(
            request: request,
            predicate: predicate
        )
        
        let fetchedRecipesByGrocery = try fetchRecipesByGrocery(name: keyword)
        
        let result = (fetchedRecipesByTitleOrTag + fetchedRecipesByGrocery).removeDuplicate()
        let sortedResult = sort(result, with: sorts)
        return sortedResult.map { $0.toDomain() }
    }
    
    private func fetchRecipesByGrocery(name: String) throws -> [CDRecipe] {
        let request = CDGrocery.fetchRequest()
        let predicate = NSPredicate(format: "name LIKE %@", name.lowercased())
        
        guard let fetchedGrocery = try coreDataProvider.fetch(
            request: request,
            predicate: predicate,
            sortDiscriptors: nil).first,
              let fetcehdIngredients: NSSet = fetchedGrocery.ingredients else {
            return []
        }
        
        let ingredients = Array<CDIngredient>(Set(_immutableCocoaSet: fetcehdIngredients))
        let ingredientGroups = ingredients.map { $0.ingredientGroup }
        let recipes = ingredientGroups.compactMap { $0?.recipe }
        
        return recipes
    }
    
    func fetchRecipesByBookID(
        _ bookdId: UUID,
        sorts: [RecipeSortDescriptor: Bool])
    throws -> [Recipe]
    {
        let request = CDRecipeBook.fetchRequest()
        let predicate = NSPredicate(format: "id == %@", bookdId as CVarArg)
        
        guard let fetchedRecipeBook = try coreDataProvider.fetch(
            request: request,
            predicate: predicate,
            sortDiscriptors: nil).first,
              let fetchedRecipes = fetchedRecipeBook.recipes else {
            return []
        }
        
        let sortDescriptors = createSortDescriptor(with: sorts)
        let sortedRecipes = (fetchedRecipes.allObjects as NSArray)
            .sortedArray(using: sortDescriptors)
            .compactMap{ $0 as? Recipe }
        return sortedRecipes
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
                    try! $0.toEntity(coreDataProvider: coreDataProvider) } ?? [])
        )
        recipe.addToIngredientGroups(
            NSSet(
                array: model.ingredientsGroups?.map {
                    $0.toEntity(coreDataProvider: coreDataProvider) } ?? [])
        )
        recipe.addToProgress(
            NSSet(
                array: model.progress?.map {
                    $0.toEntity(coreDataProvider: coreDataProvider) } ?? [])
        )
        
        try? self.coreDataProvider.context.save()
    }
    
    func updateRecipe(_ recipe: Recipe) throws {
        let recipeEntity = try fetchRecipeEntity(id: recipe.id)
        recipeEntity.title = recipe.title
        recipeEntity.subTitle = recipe.subTitle
        recipeEntity.tags = NSSet(
            array: recipe.tags?.compactMap {
                try! $0.toEntity(coreDataProvider: coreDataProvider) } ?? []
        )
        recipeEntity.ingredientGroups = NSSet(
            array: recipe.ingredientsGroups?.compactMap {
                $0.toEntity(coreDataProvider: coreDataProvider) } ?? []
        )
        recipeEntity.cookingTime = Int64(recipe.cookingTime ?? -1)
        recipeEntity.progress = NSSet(
            array: recipe.progress?.compactMap {
                $0.toEntity(coreDataProvider: coreDataProvider) } ?? []
        )
        recipeEntity.descriptions = recipe.description
        recipeEntity.note = recipe.note
        recipeEntity.serving = Int64(recipe.serving ?? -1)
        recipeEntity.image = recipe.image
        recipeEntity.updatedAt = recipe.updatedAt
        
        try self.coreDataProvider.context.save()
    }
    
    func deleteRecipe(_ recipe: Recipe) throws {
        let recipeEntity = try fetchRecipeEntity(id: recipe.id)
        try self.coreDataProvider.delete(object: recipeEntity)
    }
    
    private func createSortDescriptor(
        with sortDescriptors: [RecipeSortDescriptor: Bool]
    ) -> [NSSortDescriptor]
    {
        return sortDescriptors.map { (key: RecipeSortDescriptor, value: Bool) in
            NSSortDescriptor(key: key.rawValue, ascending: value)
        }
    }
}
