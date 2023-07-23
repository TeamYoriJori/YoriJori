//
//  RecipeRepository.swift
//  YoriJori
//
//  Created by forest on 2023/06/25.
//

import Foundation

protocol RecipeRepositoryProtocol {
    func fetchAllRecipes() throws -> [Recipe]
    func fetchRecipeByID(_ id: UUID) throws -> Recipe?
    func fetchRecipesByTitle(_ title: String, sorts: [RecipeSortDescriptor: Bool]) throws -> [Recipe]
    func fetchRecipesByKeyword(_ keyword: String, sorts: [RecipeSortDescriptor: Bool]) throws -> [Recipe]
    func fetchRecipesByBookID(_ bookdId: UUID, sorts: [RecipeSortDescriptor: Bool]) throws -> [Recipe]
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
