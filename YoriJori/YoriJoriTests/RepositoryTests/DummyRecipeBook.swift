//
//  DummyRecipeBook.swift
//  YoriJoriTests
//
//  Created by forest on 2023/08/03.
//

import Foundation
@testable import YoriJori

enum DummyRecipeBook {
    static let baseDate = Date.now
    
    static let korean = RecipeBook(
        id: UUID(),
        title: "한식",
        image: nil,
        updatedAt: Date(timeInterval: 100, since: baseDate),
        recipes: []
    )
    
    static let japanese = RecipeBook(
        id: UUID(),
        title: "일식",
        image: nil,
        updatedAt: Date(timeInterval: 300, since: baseDate),
        recipes: []
    )
    
    static let western = RecipeBook(
        id: UUID(),
        title: "양식",
        image: nil,
        updatedAt: Date(timeInterval: 500, since: baseDate),
        recipes: []
    )
}
