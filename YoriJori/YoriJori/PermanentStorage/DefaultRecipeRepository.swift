//
//  DefaultRecipeStorage.swift
//  YoriJori
//
//  Created by forest on 2023/06/25.
//

import Foundation
import CoreData


class RecipeRepository: RecipeRepositoryProtocol {
    
    let coreDataProvider: CoreDataProvider
    
    init(coreDataProvider: CoreDataProvider) {
        self.coreDataProvider = coreDataProvider
    }
    
    func fetchRecipe() throws -> [Recipe] {
        let request = CDRecipe.fetchRequest()
        let result = try coreDataProvider.fetch(request: request)
        
        return result.map { $0.toDomain() }
    }
    
    func fetchRecipe(by name: String) throws -> [Recipe] {
        let request = CDRecipe.fetchRequest()
        let predicate = NSPredicate(format: "title == %@", name)
        
        let result = try coreDataProvider.fetch(request: request, predicate: predicate)
        
        return result.map { $0.toDomain() }
    }
    
    func fetchRecipe(by bookdId: UUID) throws -> [Recipe] {
        let request = CDRecipe.fetchRequest()
        let predicate = NSPredicate(format: "id == %@", bookdId as CVarArg)
        
        let result = try coreDataProvider.fetch(request: request, predicate: predicate)
        
        //        return result.map { $0.toDomain() }
        return []
    }
    
    func createRecipe(_ model: Recipe) throws {
        let recipe = CDRecipe(context: self.coreDataProvider.context)
        let ingredientGroups = model.ingredientsGroups?.compactMap { createIngredientGroup($0) }
        let progress = model.progress?.compactMap { createStep($0) }
        var tags: [CDTag]? = model.tags?.map { tagModel in
            let tag = self.fetchTag(tagModel.name) ?? self.createTag(tagModel)
            return tag
        }
        
        recipe.id = model.id
        recipe.cookingTime = Int64(model.cookingTime ?? -1)
        recipe.createdAt = model.createdAt
        recipe.descriptions = model.description
        recipe.image = model.image
        recipe.note = model.note
        recipe.serving = Int64(model.serving ?? -1)
        recipe.subTitle = model.subTitle
        recipe.title = model.title
        recipe.updatedAt = model.updatedAt
        recipe.addToIngredientGroups(NSSet(array: ingredientGroups ?? []))
        recipe.addToProgress(NSSet(array: progress ?? []))
        recipe.addToTags(NSSet(array: tags ?? []))
        
        try? self.coreDataProvider.context.save()
    }
    
    func createIngredientGroup(_ model: IngreidentGroup) -> CDIngredientGroup {
        var ingridientGroup = CDIngredientGroup(context: self.coreDataProvider.context)
        ingridientGroup.title = model.title
        ingridientGroup.ingredients = model.ingredients?.compactMap { createIngredient($0) } as? NSSet
        return ingridientGroup
    }
    
    func createIngredient(_ model: Ingredient) -> CDIngredient {
        let ingredient = CDIngredient(context: self.coreDataProvider.context)
        ingredient.title = model.title
        ingredient.amount = model.amount!
        ingredient.unit = model.unit.rawValue
        return ingredient
    }
    
    func createStep(_ model: Step) -> CDStep {
        let step = CDStep(context: self.coreDataProvider.context)
        step.groceries = model.groceries?.map { createGrocery($0) } as? NSSet
        step.descriptions = model.description
        step.index = Int64(model.index)
        step.image = model.image
        step.time = Int64(model.time ?? -1)
        return step
    }
    
    func createGrocery(_ model: Grocery) -> CDGrocery {
        let grocery = CDGrocery(context: self.coreDataProvider.context)
        grocery.name = model.name
        return grocery
    }
    
    func createTag(_ model: Tag) -> CDTag {
        let tag = CDTag(context: self.coreDataProvider.context)
        tag.name  = model.name
        return tag
    }
    
    func fetchTag(_ query: String) -> CDTag? {
        let request = CDTag.fetchRequest()
        let predicate = NSPredicate(format: "name == %@", query)
        return try? coreDataProvider.fetch(request: request, predicate: predicate).first
    }
    
    func updateRecipe(recipe: Recipe) throws {
        let request = CDRecipe.fetchRequest()
        let predicate = NSPredicate(format: "id == %@", recipe.id.uuidString)
        guard let recipeEntity = try? coreDataProvider.fetch(request: request, predicate: predicate).first else { return }
        
        recipeEntity.setValue(recipe.progress?.compactMap { $0.toEntity(coreDataProvider.context) }, forKey: "step")
        
        try self.coreDataProvider.context.save()
    }
    
    func deleteRecipe(recipe: Recipe) throws {
        let request = CDRecipe.fetchRequest()
        let predicate = NSPredicate(format: "id == %@", recipe.id.uuidString)
        guard let recipeEntity = try? coreDataProvider.fetch(request: request, predicate: predicate).first else { return }
        
        try self.coreDataProvider.delete(object: recipeEntity)
    }
    
}

extension Step {
    func toEntity(_ context: NSManagedObjectContext) -> CDStep {
        let step = CDStep(context: context)
        step.groceries = self.groceries?.map { $0.toEntity(context) } as? NSSet
        step.descriptions = self.description
        step.index = Int64(self.index)
        step.image = self.image
        step.time = Int64(self.time ?? -1)
        return step
    }
}

extension Grocery {
    func toEntity(_ context: NSManagedObjectContext) -> CDGrocery {
        let grocery = CDGrocery(context: context)
        grocery.name = self.name
        return grocery
    }
}
