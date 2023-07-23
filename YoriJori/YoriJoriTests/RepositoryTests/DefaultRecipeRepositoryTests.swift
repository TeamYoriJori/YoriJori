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
        let expectedRecipe = try? sut.fetchRecipesByTitle("햄버거", sorts: [:])
        XCTAssertEqual(recipe, expectedRecipe?.first)
    }
    
    func test_fetchRecipeByID() throws {
        // Arrange
        let recipe = DummyRecipe.hamburger
        
        // Act
        try sut.createRecipe(recipe)
        
        // Assert
        let result = try? sut.fetchRecipeByID(recipe.id)
        XCTAssertEqual(result, recipe)
    }
    
    func test_fetchRecipeByTitle() throws {
        // Arrange
        let recipe = DummyRecipe.hamburger
        
        // Act
        try sut.createRecipe(recipe)
        
        // Assert
        let result = try? sut.fetchRecipesByTitle(recipe.title!, sorts: [:])
        XCTAssertEqual(result?.first, recipe)
    }
    
    func test_fetchRecipeByTitle_whenTitleOfUpperAndLowerCase() throws {
        // Arrange
        let recipe = DummyRecipe.mojito
        
        // Act
        try sut.createRecipe(recipe)
        
        // Assert
        let result = try? sut.fetchRecipesByTitle("Mojito", sorts: [:])
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
        let result = try? sut.fetchRecipesByTitle("스시", sorts: [.cookingTimeAscending: true])
        XCTAssertEqual(result, [sakeDongRecipe, sushiRecipe])
    }
    
    func test_fetchRecipesByKeywordWithUpdatedAtSorting() throws {
        // Arrange
        let sushiRecipe = DummyRecipe.sushi // 스시
        let sakeDongRecipe = DummyRecipe.sakeDong // 스시로 만든 사케동
        try sut.createRecipe(sushiRecipe)
        try sut.createRecipe(sakeDongRecipe)
        
        // Act
        let result = try sut.fetchRecipesByKeyword("스시", sorts: [.updatedAtAscending: false])
        
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
        let result = try sut.fetchRecipesByKeyword("스", sorts: [.titleAscending: true])
        
        // Assert
        XCTAssertEqual(result, [sushiRecipe, creamSpaghetti])
    }
    
    func test_fetchRecipesByTagWithTitleAscendingSorting() throws {
        // Arrange
        let hamburgerRecipe = DummyRecipe.hamburger
        let sushiRecipe = DummyRecipe.sushi
        let creamSpaghettiRecipe = DummyRecipe.creamSpaghetti
        try sut.createRecipe(hamburgerRecipe)
        try sut.createRecipe(sushiRecipe)
        try sut.createRecipe(creamSpaghettiRecipe)
        
        // Act
        let result = try sut.fetchRecipesByKeyword("소울푸드", sorts: [.titleAscending: true])
        
        // Assert
        XCTAssertEqual(result, [sushiRecipe, hamburgerRecipe])
    }
    
    func test_fetchRecipesByGrocery_RegardlessOfCase() throws {
        // Arrange
        let creamSpaghettiRecipe = Recipe(
            id: UUID(),
            title: "크림 스파게티",
            subTitle: "냠냠",
            tags: [.init(name: "양식")],
            ingredientsGroups: [
                IngreidentGroup(
                    title: "주재료",
                    ingredients: [Ingredient(grocery: .init(name: "스파게티면"), amount: 500, unit: .init(rawValue: "g")!)]
                ),
                IngreidentGroup(
                    title: "소스",
                    ingredients: [Ingredient(grocery: .init(name: "cream"), amount: 100, unit: .init(rawValue: "g")!),
                                  Ingredient(grocery: .init(name: "페퍼론치노"), amount: 30, unit: .init(rawValue: "g")!)]
                )],
            cookingTime: 800,
            progress: [Step(index: 1, description: "면을 삼는다", image: nil, time: 300, groceries: [Grocery(name: "스파게티면")])],
            description: "본아쁘띠🍝",
            note: nil,
            serving: 1,
            image: nil,
            createdAt: Date(),
            updatedAt: Date(timeInterval: 100, since: Date())
        )
        
        let risottoReceipe = Recipe(
            id: UUID(),
            title: "리조또",
            subTitle: "냠냠",
            tags: [.init(name: "양식")],
            ingredientsGroups: [
                IngreidentGroup(
                    title: "주재료",
                    ingredients: [Ingredient(grocery: .init(name: "스파게티면"), amount: 500, unit: .init(rawValue: "g")!)]
                ),
                IngreidentGroup(
                    title: "소스",
                    ingredients: [Ingredient(grocery: .init(name: "Cream"), amount: 100, unit: .init(rawValue: "g")!),
                                  Ingredient(grocery: .init(name: "페퍼론치노"), amount: 30, unit: .init(rawValue: "g")!)]
                )],
            cookingTime: 800,
            progress: [Step(index: 1, description: "면을 삼는다", image: nil, time: 300, groceries: [Grocery(name: "스파게티면")])],
            description: "본아쁘띠🍝",
            note: nil,
            serving: 1,
            image: nil,
            createdAt: Date(),
            updatedAt: Date(timeInterval: 100, since: Date())
        )
        try sut.createRecipe(creamSpaghettiRecipe)
        try sut.createRecipe(risottoReceipe)
        
        // Act
        let result = try sut.fetchRecipesByKeyword("cream", sorts: [.titleAscending: true])
        
        // Assert
        XCTAssertEqual(result, [risottoReceipe, creamSpaghettiRecipe])
    }
}
