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
    
    func test_fetchRecipesByTitle_whenSortsDescriptorsCountIsTwo() throws {
        // Arrange
        let creamSpaghettiRecipe = Recipe(
            id: UUID(),
            title: "크림 스파게티",
            subTitle: "냠냠",
            tags: [.init(name: "양식")],
            ingredientsGroups: [],
            cookingTime: 800,
            progress: [],
            description: "본아쁘띠🍝",
            note: nil,
            serving: 1,
            image: nil,
            createdAt: Date(),
            updatedAt: Date(timeInterval: 100, since: Date())
        )
        let creamSpaghettiRecipe2 = Recipe(
            id: UUID(),
            title: "크림 스파게티",
            subTitle: "냠냠",
            tags: [.init(name: "양식")],
            ingredientsGroups: [],
            cookingTime: 900,
            progress: [],
            description: "본아쁘띠🍝",
            note: nil,
            serving: 1,
            image: nil,
            createdAt: Date(),
            updatedAt: Date(timeInterval: 100, since: Date())
        )
        let shuCreamReceipe = Recipe(
            id: UUID(),
            title: "슈크림",
            subTitle: "냠냠",
            tags: [.init(name: "크림")],
            ingredientsGroups: [],
            cookingTime: 800,
            progress: [],
            description: "본아쁘띠🍝",
            note: nil,
            serving: 1,
            image: nil,
            createdAt: Date(),
            updatedAt: Date(timeInterval: 100, since: Date())
        )
        try sut.createRecipe(creamSpaghettiRecipe)
        try sut.createRecipe(creamSpaghettiRecipe2)
        try sut.createRecipe(shuCreamReceipe)
        
        // Act
        let result = try sut.fetchRecipesByTitle("크림", sorts: [.titleAscending: true, .cookingTimeAscending: true])
        
        // Assert
        XCTAssertEqual(result, [shuCreamReceipe, creamSpaghettiRecipe, creamSpaghettiRecipe2])
    }
    
    // FIXME: - Array 일관성있게 순서대로 작동하지 않음
    func test_fetchRecipesByTitle_whenSortsDescriptorsCountIsThree() throws {
        // Arrange
        let date = Date()
        let creamSpaghettiRecipe = Recipe(
            id: UUID(),
            title: "크림스파게티",
            subTitle: "냠냠",
            tags: [.init(name: "양식")],
            ingredientsGroups: [],
            cookingTime: 800,
            progress: [],
            description: "본아쁘띠🍝",
            note: nil,
            serving: 1,
            image: nil,
            createdAt: Date(),
            updatedAt: Date(timeInterval: 100, since: date)
        )
        let creamSpaghettiRecipe2 = Recipe(
            id: UUID(),
            title: "크림스파게티",
            subTitle: "냠냠",
            tags: [.init(name: "양식")],
            ingredientsGroups: [],
            cookingTime: 900,
            progress: [],
            description: "본아쁘띠🍝",
            note: nil,
            serving: 1,
            image: nil,
            createdAt: Date(),
            updatedAt: Date(timeInterval: 300, since: date)
        )
        let shuCreamReceipe = Recipe(
            id: UUID(),
            title: "슈크림",
            subTitle: "냠냠",
            tags: [.init(name: "크림")],
            ingredientsGroups: [],
            cookingTime: 800,
            progress: [],
            description: "본아쁘띠🍝",
            note: nil,
            serving: 1,
            image: nil,
            createdAt: Date(),
            updatedAt: Date(timeInterval: 300, since: date)
        )
        let creamSoupReceipe = Recipe(
            id: UUID(),
            title: "크림수프",
            subTitle: "냠냠",
            tags: [.init(name: "크림")],
            ingredientsGroups: [],
            cookingTime: 800,
            progress: [],
            description: "본아쁘띠🍝",
            note: nil,
            serving: 1,
            image: nil,
            createdAt: Date(),
            updatedAt: Date(timeInterval: 100, since: date)
        )
        try sut.createRecipe(creamSpaghettiRecipe)
        try sut.createRecipe(creamSpaghettiRecipe2)
        try sut.createRecipe(shuCreamReceipe)
        try sut.createRecipe(creamSoupReceipe)
        
        // Act
        // HINT: Array 내 나타나는 순서대로 정렬이 실행됨
        let result = try sut.fetchRecipesByTitle("크림", sorts: [.updatedAtAscending: true ,.titleAscending: true, .cookingTimeAscending: true])
        
        // Assert
        XCTAssertEqual(result, [creamSoupReceipe, creamSpaghettiRecipe, shuCreamReceipe, creamSpaghettiRecipe2])
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
    
    func test_fetchRecipesByKeyword_whenKeywordIsTitleOrTagOrGrocery() throws {
        // Arrange
        let creamSpaghettiRecipe = Recipe(
            id: UUID(),
            title: "크림 스파게티",
            subTitle: "냠냠",
            tags: [.init(name: "양식")],
            ingredientsGroups: [],
            cookingTime: 800,
            progress: [],
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
                    ingredients: [Ingredient(grocery: .init(name: "크림"), amount: 100, unit: .init(rawValue: "g")!),
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
        let shuCreamReceipe = Recipe(
            id: UUID(),
            title: "슈크림",
            subTitle: "냠냠",
            tags: [.init(name: "크림")],
            ingredientsGroups: [],
            cookingTime: 800,
            progress: [],
            description: "본아쁘띠🍝",
            note: nil,
            serving: 1,
            image: nil,
            createdAt: Date(),
            updatedAt: Date(timeInterval: 100, since: Date())
        )
        try sut.createRecipe(creamSpaghettiRecipe)
        try sut.createRecipe(risottoReceipe)
        try sut.createRecipe(shuCreamReceipe)
        
        // Act
        let result = try sut.fetchRecipesByKeyword("크림", sorts: [.titleAscending: true])
        
        // Assert
        XCTAssertEqual(result, [risottoReceipe, shuCreamReceipe, creamSpaghettiRecipe])
    }
    
    func test_updateRecipeTitle() throws {
        // Arrange
        let id = UUID()
        let recipe = Recipe(
            id: id,
            title: "슈크림",
            subTitle: "냠냠",
            tags: [.init(name: "크림")],
            ingredientsGroups: [],
            cookingTime: 800,
            progress: [],
            description: "본아쁘띠🍝",
            note: nil,
            serving: 1,
            image: nil,
            createdAt: Date(),
            updatedAt: Date(timeInterval: 100, since: Date())
        )
        try sut.createRecipe(recipe)
        let newRecipe = Recipe(
            id: id,
            title: "크림 빵",
            subTitle: "냠냠",
            tags: [.init(name: "크림")],
            ingredientsGroups: [],
            cookingTime: 800,
            progress: [],
            description: "본아쁘띠🍝",
            note: nil,
            serving: 1,
            image: nil,
            createdAt: Date(),
            updatedAt: Date(timeInterval: 100, since: Date())
        )
        try sut.createRecipe(recipe)
        
        // Act
        try sut.updateRecipe(newRecipe)
        
        // Assert
        let result = try sut.fetchRecipeByID(id)
        XCTAssertEqual(result, newRecipe)
    }
    
    func test_updateRecipeTag() throws {
        // Arrange
        let id = UUID()
        let recipe = Recipe(
            id: id,
            title: "슈크림",
            subTitle: "냠냠",
            tags: [.init(name: "크림")],
            ingredientsGroups: [],
            cookingTime: 800,
            progress: [],
            description: "본아쁘띠🍝",
            note: nil,
            serving: 1,
            image: nil,
            createdAt: Date(),
            updatedAt: Date(timeInterval: 100, since: Date())
        )
        try sut.createRecipe(recipe)
        let newRecipe = Recipe(
            id: id,
            title: "슈크림",
            subTitle: "냠냠",
            tags: [.init(name: "디저트")],
            ingredientsGroups: [],
            cookingTime: 800,
            progress: [],
            description: "본아쁘띠🍝",
            note: nil,
            serving: 1,
            image: nil,
            createdAt: Date(),
            updatedAt: Date(timeInterval: 100, since: Date())
        )
        try sut.createRecipe(recipe)
        
        // Act
        try sut.updateRecipe(newRecipe)
        
        // Assert
        let result = try sut.fetchRecipeByID(id)
        XCTAssertEqual(result, newRecipe)
    }
    
    func test_updateRecipeIngredient() throws {
        // Arrange
        let id = UUID()
        let recipe = Recipe(
            id: id,
            title: "슈크림",
            subTitle: "냠냠",
            tags: [.init(name: "디저트")],
            ingredientsGroups: [.init(title: "주재료", ingredients: [.init(grocery: .init(name: "바닐라빈"), amount: 600, unit: .g)])],
            cookingTime: 800,
            progress: [],
            description: "본아쁘띠🍝",
            note: nil,
            serving: 1,
            image: nil,
            createdAt: Date(),
            updatedAt: Date(timeInterval: 100, since: Date())
        )
        try sut.createRecipe(recipe)
        let newRecipe = Recipe(
            id: id,
            title: "슈크림",
            subTitle: "냠냠",
            tags: [.init(name: "디저트")],
            ingredientsGroups: [],
            cookingTime: 800,
            progress: [],
            description: "본아쁘띠🍝",
            note: nil,
            serving: 1,
            image: nil,
            createdAt: Date(),
            updatedAt: Date(timeInterval: 100, since: Date())
        )
        try sut.createRecipe(recipe)
        
        // Act
        try sut.updateRecipe(newRecipe)
        
        // Assert
        let result = try sut.fetchRecipeByID(id)
        XCTAssertEqual(result, newRecipe)
    }
    
    func test_updateRecipeProgress() throws {
        // Arrange
        let id = UUID()
        let recipe = Recipe(
            id: id,
            title: "슈크림",
            subTitle: "냠냠",
            tags: [.init(name: "디저트")],
            ingredientsGroups: [.init(title: "주재료", ingredients: [.init(grocery: .init(name: "바닐라빈"), amount: 600, unit: .g)])],
            cookingTime: 800,
            progress: [Step(index: 0, description: "바닐라빈을 준비한다", image: nil, time: 50, groceries: [.init(name: "바닐라빈")])],
            description: "본아쁘띠🍝",
            note: nil,
            serving: 1,
            image: nil,
            createdAt: Date(),
            updatedAt: Date(timeInterval: 100, since: Date())
        )
        try sut.createRecipe(recipe)
        let newRecipe = Recipe(
            id: id,
            title: "슈크림",
            subTitle: "냠냠",
            tags: [.init(name: "디저트")],
            ingredientsGroups: [],
            cookingTime: 800,
            progress: [
                Step(index: 0, description: "바닐라빈을 준비한다", image: nil, time: 50, groceries: [.init(name: "바닐라빈")]),
                Step(index: 1, description: "계량한다", image: nil, time: 60, groceries: nil)
            ],
            description: "본아쁘띠🍝",
            note: nil,
            serving: 1,
            image: nil,
            createdAt: Date(),
            updatedAt: Date(timeInterval: 100, since: Date())
        )
        try sut.createRecipe(recipe)
        
        // Act
        try sut.updateRecipe(newRecipe)
        
        // Assert
        let result = try sut.fetchRecipeByID(id)
        XCTAssertEqual(result, newRecipe)
    }
    
    func test_deleteRecipe() throws {
        // Arrnage
        let id = UUID()
        let recipe = Recipe(
            id: id,
            title: "슈크림",
            subTitle: "냠냠",
            tags: [.init(name: "디저트")],
            ingredientsGroups: [.init(title: "주재료", ingredients: [.init(grocery: .init(name: "바닐라빈"), amount: 600, unit: .g)])],
            cookingTime: 800,
            progress: [Step(index: 0, description: "바닐라빈을 준비한다", image: nil, time: 50, groceries: [.init(name: "바닐라빈")])],
            description: "본아쁘띠🍝",
            note: nil,
            serving: 1,
            image: nil,
            createdAt: Date(),
            updatedAt: Date(timeInterval: 100, since: Date())
        )
        
        // Act
        try sut.deleteRecipe(recipe)
        
        // Assert
        let fetchedRecipe = try sut.fetchRecipeByID(id)
        XCTAssertNil(fetchedRecipe)
    }
    
    // MARK: - RecipeBook을 지정하는 케이스 테스트

    // TODO: - fetchRecipesByBookID 테스트
}
