//
//  DefaultRecipeRepositoryTests.swift
//  YoriJoriTests
//
//  Created by moon Lily on 2023/07/16.
//

import XCTest
@testable import YoriJori

final class DefaultRecipeRepositoryTests: XCTestCase {
    
    private var sut: RecipeRepository!

    override func setUpWithError() throws {
        try super.setUpWithError()
        let inMemroyCoreDataProvider = CoreDataProvider(.inMemory)
        sut = RecipeRepository(coreDataProvider: inMemroyCoreDataProvider)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }

    // MARK: - RecipeBook을 지정하는 케이스 테스트

    
    // MARK: - RecipeBook을 지정하지 않는 케이스 테스트
    
    func test_createRecipe() throws {
        // Arrange
        let recipe = DummyRecipe.hamburger
        
        // Assert
        try sut.createRecipe(recipe)
        
        // Act
        let expectedRecipe = try? sut.fetchRecipes(by: "햄버거", sorts: [:])
        XCTAssertEqual(recipe, expectedRecipe?.first)
    }
    
    func test_fetchRecipeByID() throws {
        // Arrange
        let recipe = DummyRecipe.hamburger
        
        // Assert
        try sut.createRecipe(recipe)
        
        // Act
        let result = try? sut.fetchRecipes(by: recipe.id)
        XCTAssertEqual(result, recipe)
    }
    
    func test_fetchRecipesByName() throws {
        // Arrange
        let sushiRecipe = DummyRecipe.sushi // 스시
        let sushiSakeDongRecipe = DummyRecipe.sakeDong // 스시로 만든 사케동
        try sut.createRecipe(sushiRecipe)
        try sut.createRecipe(sushiSakeDongRecipe)
        
        // Assert
        let result = try sut.fetchRecipes(by: "스시", sorts: [.updatedAtAscending: false])
        
        // Act
        XCTAssertEqual(result, [sushiSakeDongRecipe, sushiRecipe])
    }
    
    func test_fetchRecipesByNameWithSorting() throws {
        // Arrange
        let sushiRecipe = DummyRecipe.sushi // 스시
        let creamSpaghetti = DummyRecipe.creamSpaghetti // 크림 스파게티
        try sut.createRecipe(sushiRecipe)
        try sut.createRecipe(creamSpaghetti)
        
        // Assert
        let result = try sut.fetchRecipes(by: "스", sorts: [.titleAscending: true])
        
        // Act
        XCTAssertEqual(result, [sushiRecipe, creamSpaghetti])
    }
}
