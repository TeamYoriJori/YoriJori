//
//  RecipeRepository.swift
//  YoriJori
//
//  Created by forest on 2023/06/25.
//

import Foundation

protocol RecipeRepositoryProtocol {
    func fetchRecipe() throws -> [Recipe]
    func fetchRecipe(by name: String) throws -> [Recipe]
    func fetchRecipe(by bookdId: UUID) throws -> [Recipe]
    func createRecipe(_ model: Recipe) throws
    func updateRecipe(recipe: Recipe) throws
    func deleteRecipe(recipe: Recipe) throws
}
