//
//  RecipeRepository.swift
//  YoriJori
//
//  Created by forest on 2023/06/25.
//

import Foundation

protocol RecipeRepositoryProtocol {
    func fetchAllRecipes() throws -> [Recipe]
    func fetchRecipes(by id: UUID) throws -> Recipe?
    func fetchRecipes(by tilte: String, sorts: [RecipeSortDescriptor: Bool]) throws -> [Recipe]
    func fetchRecipes(by bookdId: UUID, sorts: [RecipeSortDescriptor: Bool]) throws -> [Recipe]
    func fetchRecipes(by tag: Tag, sorts: [RecipeSortDescriptor: Bool]) throws -> [Recipe]
    func fetchRecipes(by grocery: Grocery, sorts: [RecipeSortDescriptor: Bool]) throws -> [Recipe]
    func createRecipe(_ model: Recipe) throws
    func updateRecipe(_ recipe: Recipe) throws
    func deleteRecipe(_ recipe: Recipe) throws
}

// rawValue는 Sorting의 key로 사용된다
enum RecipeSortDescriptor: String {
    case titleAscending = "title"
    case updatedAtAscending = "updatedAt"
    case cookingTimeAscending = "cookingTime"
}
