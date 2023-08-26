//
//  RecipeBookRepository.swift
//  YoriJori
//
//  Created by forest on 2023/08/03.
//

import Foundation

protocol RecipeBookRepositoryProtocol {
    func fetchAllRecipeBooks() throws -> [RecipeBook]
    func fetchAllRecipeBooks(by sorts: [RecipeBookSortDescriptor: Bool]) throws -> [RecipeBook]
    func fetchRecipeBookByID(_ id: UUID) throws -> RecipeBook?
    func fetchRecipeBooksByTitle(_ title: String, sorts: [RecipeBookSortDescriptor: Bool]) throws -> [RecipeBook]
    func createRecipeBook(_ model: RecipeBook) throws
    func updateRecipeBook(_ recipeBook: RecipeBook) throws
    func deleteRecipeBook(_ recipeBook: RecipeBook) throws
    func addRecipe(_ recipe: Recipe, to recipeBook: RecipeBook) throws
}

enum RecipeBookSortDescriptor: String {
    case titleAscending = "title"
    case updatedAtAscending = "updatedAt"
}

enum RecipeBookRepositoryError: Error {
    case RecipeBookFetchError
}
