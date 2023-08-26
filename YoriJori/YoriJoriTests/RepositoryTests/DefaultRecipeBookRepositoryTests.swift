//
//  DefaultRecipeBookRepositoryTests.swift
//  YoriJoriTests
//
//  Created by forest on 2023/08/03.
//

import XCTest
@testable import YoriJori

final class DefaultRecipeBookRepositoryTests: XCTestCase {

    private var sut: DefaultRecipeBookRepository!
    private var sut2: DefaultRecipeRepository!

    override func setUpWithError() throws {
        try super.setUpWithError()
        let inMemroyCoreDataProvider = CoreDataProvider(.inMemory)
        sut = DefaultRecipeBookRepository(coreDataProvider: inMemroyCoreDataProvider)
        sut2 = DefaultRecipeRepository(coreDataProvider: inMemroyCoreDataProvider)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
        sut2 = nil
    }
    
    func test_createRecipeBook()  throws {
        // Arrange
        let recipeBook = DummyRecipeBook.korean
        
        // Act
        try sut.createRecipeBook(recipeBook)
        
        // Assert
        let expectedRecipeBook = try? sut.fetchRecipeBooksByTitle("한식", sorts: [:])
        XCTAssertEqual(recipeBook, expectedRecipeBook?.first)
    }
    
    func test_deleteRecipeBook()  throws {
        // Arrange
        let recipeBook = DummyRecipeBook.korean
        
        // Act
        try sut.createRecipeBook(recipeBook)
        try sut.deleteRecipeBook(recipeBook)
        
        // Assert
        let expectedRecipeBook = try? sut.fetchRecipeBooksByTitle("한식", sorts: [:])
        XCTAssertNil(expectedRecipeBook?.first)
    }
    
    func test_deleteRecipeBookDeletesAllRecipes()  throws {
        // Arrange
        let recipeBook = DummyRecipeBook.korean
        let recipe1 = DummyRecipe.sushi
        let recipe2 = DummyRecipe.sakeDong
        try sut.createRecipeBook(recipeBook)
        try sut2.createRecipe(recipe1)
        try sut2.createRecipe(recipe2)
        try sut.addRecipe(recipe1, to: recipeBook)
        try sut.addRecipe(recipe2, to: recipeBook)
        
        // Act
        try sut.deleteRecipeBook(recipeBook)
        
        // Assert
        let fetchedRecipes = try sut2.fetchAllRecipes()
        XCTAssertEqual(fetchedRecipes.count, 0)
    }
    
    func test_updateRecipeBook() throws {
        // Arrange
        let recipeBook = DummyRecipeBook.korean
        let recipeBookUpdatedName = RecipeBook(
            id: recipeBook.id,
            title: "한국음식",
            image: nil,
            updatedAt: Date(),
            recipes: []
        )
        // Act
        try sut.createRecipeBook(recipeBook)
        try sut.updateRecipeBook(recipeBookUpdatedName)
        
        // Assert
        let expectedRecipeBook = try? sut.fetchRecipeBookByID(recipeBookUpdatedName.id)
        XCTAssertEqual(recipeBookUpdatedName.title, expectedRecipeBook?.title)
    }
    
    func test_fetchAllRecipeBook() throws {
        // Arrange
        let firstRecipeBook = DummyRecipeBook.korean
        let secondRecipeBook = DummyRecipeBook.japanese
        
        try sut.createRecipeBook(firstRecipeBook)
        try sut.createRecipeBook(secondRecipeBook)
        
        // Act
        let result = try sut.fetchAllRecipeBooks()
        
        // Assert
        XCTAssertEqual(result.count, 2)
    }
    
    func test_fetchAllRecipeBooksWithUpdatedAtSorting() throws {
        // Arrange
        let firstRecipeBook = DummyRecipeBook.korean
        let secondRecipeBook = DummyRecipeBook.japanese
        
        try sut.createRecipeBook(firstRecipeBook)
        try sut.createRecipeBook(secondRecipeBook)
        
        // Act
        let result = try sut.fetchAllRecipeBooks(by: [.updatedAtAscending: true])
        
        // Assert
        XCTAssertEqual(result, [firstRecipeBook, secondRecipeBook])
    }
    
    func test_fetchAllRecipeBooksWithTitleSorting() throws {
        // Arrange
        let koreanRecipeBook = DummyRecipeBook.korean
        let japaneseRecipeBook = DummyRecipeBook.japanese
        
        try sut.createRecipeBook(koreanRecipeBook)
        try sut.createRecipeBook(japaneseRecipeBook)
        
        // Act
        let result = try sut.fetchAllRecipeBooks(by: [.titleAscending: true])
        
        // Assert
        XCTAssertEqual(result, [japaneseRecipeBook, koreanRecipeBook])
    }
    
    func test_addRecipeToRecipeBook() throws {
        // Arrange
        let recipe = DummyRecipe.sushi
        let recipeBook = DummyRecipeBook.japanese
        try sut2.createRecipe(recipe)
        try sut.createRecipeBook(recipeBook)
        
        // Act
        try sut.addRecipe(recipe, to: recipeBook)
        
        // Assert
        let updatedRecipeBook = try sut.fetchRecipeBookByID(recipeBook.id)
        XCTAssertEqual(updatedRecipeBook?.recipes, [recipe])
    }
    
    func test_removeRecipeFromRecipeBook() throws {
        // Arrange
        let recipe = DummyRecipe.sushi
        let recipeBook = DummyRecipeBook.japanese
        try sut2.createRecipe(recipe)
        try sut.createRecipeBook(recipeBook)
        try sut.addRecipe(recipe, to: recipeBook)
        
        // Act
        try sut.removeRecipe(recipe, from: recipeBook)
        
        // Assert
        let updatedRecipeBook = try sut.fetchRecipeBookByID(recipeBook.id)
        XCTAssertEqual(updatedRecipeBook?.recipes?.count, 0)
    }
}
