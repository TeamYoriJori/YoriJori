//
//  RecipeEditor.swift
//  YoriJori
//
//  Created by 예지 on 10/20/24.
//

import Foundation

final class RecipeEditor {
    
    private var recipe: Recipe?
    
    private let maximumTitleLength: Int = 30
    private let maximumSubtitleLength: Int = 30
    private let maximumTagLength: Int = 20
    private let maximumDescriptionLength: Int = 1000
    private let maximumMemoLength: Int = 2000
    
    static func create() -> RecipeEditor {
        return RecipeEditor()
    }
    
    func createNewRecipe() -> Void {
        recipe = Recipe(id: UUID(), recipeBookID: nil, title: nil, subTitle: nil, tags: nil, ingredientsGroups: nil, cookingTime: nil, progress: nil, description: nil, note: nil, serving: nil, image: nil, createdAt: Date(), updatedAt: Date())
    }
    
    func open(_ recipe: Recipe) -> Void {
        self.recipe = recipe
    }
    
    func writeName(_ name: String) -> Void {
        recipe?.title = name
    }
    
    func writeSubtitle(_ nickname: String) -> Void {
        recipe?.subTitle = nickname
    }
    
    func writeTag(_ tagName: String) -> Void {
        let tag = Tag(tagName)
        recipe?.tags?.append(tag)
    }
    
    func addTo(_ recipeBook: RecipeBook) -> Void {
        //TODO: addTo 함수 구현
    }
    
    func writeImage(_ image: Data) -> Void {
        recipe?.image = image
    }
    
    func writeServing(_ serving: Int) -> Void {
        recipe?.serving = serving
    }
    
    func writeIngredient(name: String, amount: Double, unit: Unit) -> Void {
        let ingredient = Ingredient(name: name, amount: amount, unit: unit)
        recipe?.ingredientsGroups?.first?.ingredients.append(ingredient)
    }

    func deleteIngredient(_ ingredient: Ingredient) -> Void {
        recipe?.ingredientsGroups?.first?.ingredients.removeAll(where: { $0 == ingredient })
    }

    func getUnits() -> [Unit] {
        return Unit.allCases
    }

    func getIngredients() -> [Ingredient] {
        return recipe?.ingredientsGroups?.first?.ingredients ?? []
    }

    func addStep(index: Int, time: TimeInterval, ingredients: [Ingredient], description: String) -> Void {
        let step = Step(index: index, time: time, ingredients: ingredients, description: description)
        recipe?.progress?.steps.append(step)
    }

    func moveStep(from: Int, to: Int) -> Void {
        let step = recipe?.progress?.steps.remove(at: from)
        recipe?.progress?.steps.insert(step!, at: to)
    }

    func deleteStep(_ step: Step) -> Void {
        recipe?.progress?.steps.removeAll(where: { $0 == step })
    }

    func writeDescription(_ description: String) -> Void {
        recipe?.description = description
    }

    func writeUpdateDate() -> Void {
        recipe?.updatedAt = Date()
    }
    
    func saveRecipe() -> Void {
        //TODO: saveRecipe 함수 구현
    }

    func getRecipeBookList() -> [RecipeBook] {
        //TODO: getRecipeBookList 함수 구현
    }
}
