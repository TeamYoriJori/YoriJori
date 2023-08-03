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
}
