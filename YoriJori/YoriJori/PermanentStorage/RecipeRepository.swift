//
//  RecipeRepository.swift
//  YoriJori
//
//  Created by forest on 2023/06/25.
//

import Foundation

protocol RecipeRepositoryProtocol {
    func fetchAllRecipes() throws -> [Recipe]
    func fetchRecipes(by name: String) throws -> [Recipe]
    func fetchRecipes(by bookdId: UUID) throws -> [Recipe]
    func fetchRecipes(by tag: Tag) throws -> [Recipe]
    func fetchRecipes(by grocery: Grocery) throws -> [Recipe]
    func createRecipe(_ model: Recipe) throws
    func updateRecipe(_ recipe: Recipe) throws
    func deleteRecipe(_ recipe: Recipe) throws
}
