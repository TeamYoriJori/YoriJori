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

    override func setUpWithError() throws {
        try super.setUpWithError()
        let inMemroyCoreDataProvider = CoreDataProvider(.inMemory)
        sut = DefaultRecipeBookRepository(coreDataProvider: inMemroyCoreDataProvider)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }
    
    func test_createRecipeBook()  throws {
        // Arrange
        let recipeBook = DummyRecipeBook.korean
        
        // Act
        try sut.createRecipeBook(recipeBook)
        
        // Assert
        let expectedRecipe = try? sut.fetchRecipeBooksByTitle("한식", sorts: [:])
        XCTAssertEqual(recipeBook, expectedRecipe?.first)
    }
    
    func test_deleteRecipeBook()  throws {
        // Arrange
        let recipeBook = DummyRecipeBook.korean
        
        // Act
        try sut.createRecipeBook(recipeBook)
        try sut.deleteRecipeBook(recipeBook)
        
        // Assert
        let expectedRecipe = try? sut.fetchRecipeBooksByTitle("한식", sorts: [:])
        XCTAssertNil(expectedRecipe?.first)
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
        try sut.createRecipeBook(recipeBookUpdatedName)
        try sut.updateRecipeBook(recipeBookUpdatedName)
        
        // Assert
        let expectedRecipe = try? sut.fetchRecipeBookByID(recipeBookUpdatedName.id)
        XCTAssertEqual(recipeBookUpdatedName.title, expectedRecipe?.title)
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
}
