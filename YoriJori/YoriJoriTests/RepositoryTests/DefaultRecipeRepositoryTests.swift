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
        
        // Act
        try sut.createRecipe(recipe)
        
        // Assert
        let expectedRecipe = try? sut.fetchRecipes(byTitle: "햄버거", sorts: [:])
        XCTAssertEqual(recipe, expectedRecipe?.first)
    }
    
    func test_fetchRecipeByID() throws {
        // Arrange
        let recipe = DummyRecipe.hamburger
        
        // Act
        try sut.createRecipe(recipe)
        
        // Assert
        let result = try? sut.fetchRecipe(by: recipe.id)
        XCTAssertEqual(result, recipe)
    }
    
    func test_fetchRecipeByTitle() throws {
        // Arrange
        let recipe = DummyRecipe.hamburger
        
        // Act
        try sut.createRecipe(recipe)
        
        // Assert
        let result = try? sut.fetchRecipes(byTitle: recipe.title!, sorts: [:])
        XCTAssertEqual(result?.first, recipe)
    }
    
    func test_fetchRecipeByTitle_whenTitleOfUpperAndLowerCase() throws {
        // Arrange
        let recipe = DummyRecipe.mojito
        
        // Act
        try sut.createRecipe(recipe)
        
        // Assert
        let result = try? sut.fetchRecipes(byTitle: "Mojito", sorts: [:])
        XCTAssertEqual(result?.first, recipe)
    }
    
    func test_fetchRecipeByTitleWithCookingTimeSorting() throws {
        // Arrange
        let sushiRecipe = DummyRecipe.sushi
        let sakeDongRecipe = DummyRecipe.sakeDong
        
        // Act
        try sut.createRecipe(sushiRecipe)
        try sut.createRecipe(sakeDongRecipe)
        
        // Assert
        let result = try? sut.fetchRecipes(byTitle: "스시", sorts: [.cookingTimeAscending: true])
        XCTAssertEqual(result, [sakeDongRecipe, sushiRecipe])
    }
    
    func test_fetchRecipesByKeywordWithUpdatedAtSorting() throws {
        // Arrange
        let sushiRecipe = DummyRecipe.sushi // 스시
        let sakeDongRecipe = DummyRecipe.sakeDong // 스시로 만든 사케동
        try sut.createRecipe(sushiRecipe)
        try sut.createRecipe(sakeDongRecipe)
        
        // Act
        let result = try sut.fetchRecipes(by: "스시", sorts: [.updatedAtAscending: false])
        
        // Assert
        XCTAssertEqual(result, [sakeDongRecipe, sushiRecipe])
    }
    
    func test_fetchRecipesByKeywordWithTitleAscendingSorting() throws {
        // Arrange
        let sushiRecipe = DummyRecipe.sushi // 스시
        let creamSpaghetti = DummyRecipe.creamSpaghetti // 크림 스파게티
        try sut.createRecipe(sushiRecipe)
        try sut.createRecipe(creamSpaghetti)
        
        // Act
        let result = try sut.fetchRecipes(by: "스", sorts: [.titleAscending: true])
        
        // Assert
        XCTAssertEqual(result, [sushiRecipe, creamSpaghetti])
    }
}
