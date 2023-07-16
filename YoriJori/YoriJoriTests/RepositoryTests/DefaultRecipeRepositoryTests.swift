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
        let recipe = Recipe(
            id: UUID(),
            title: "햄버거",
            subTitle: "릴리의 소울푸드",
            tags: [.init(name: "소울푸드")],
            ingredientsGroups: [IngreidentGroup(
                title: "주재료",
                ingredients: [Ingredient(grocery: .init(name: "번"), amount: 2, unit: .init(rawValue: "개")!),
                              Ingredient(grocery: .init(name: "소고기"), amount: 300, unit: .init(rawValue: "g")!)])],
            cookingTime: 600,
            progress: [Step(index: 1, description: "소고기로 패티를 만든다", image: nil, time: 300, groceries: [Grocery(name: "소고기")])],
            description: "특제 레시피",
            note: nil,
            serving: 1,
            image: nil,
            createdAt: Date(),
            updatedAt: Date()
        )
        
        // Assert
        try sut.createRecipe(recipe)
        
        // Act
        let expectedRecipe = try? sut.fetchRecipes(by: "햄버거", sorts: [:])
        XCTAssertEqual(recipe, expectedRecipe?.first)
    }
}
