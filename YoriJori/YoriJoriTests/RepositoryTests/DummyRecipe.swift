//
//  DummyRecipe.swift
//  YoriJoriTests
//
//  Created by moon Lily on 2023/07/16.
//

import Foundation
@testable import YoriJori

enum DummyRecipe {
    
    static let baseDate = Date.now
    
    static let hamburger = Recipe(
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
    
    static let sushi = Recipe(
        id: UUID(),
        title: "스시",
        subTitle: "초간단 스시 레시피",
        tags: [.init(name: "소울푸드"), .init(name: "일식")],
        ingredientsGroups: [IngreidentGroup(
            title: "주재료",
            ingredients: [Ingredient(grocery: .init(name: "연어"), amount: 500, unit: .init(rawValue: "g")!),
                          Ingredient(grocery: .init(name: "쌀"), amount: 300, unit: .init(rawValue: "g")!)])],
        cookingTime: 800,
        progress: [Step(index: 1, description: "밥을 짓는다", image: nil, time: 300, groceries: [Grocery(name: "쌀")])],
        description: "이타다끼마스🍣",
        note: nil,
        serving: 1,
        image: nil,
        createdAt: baseDate,
        updatedAt: Date(timeInterval: 100, since: baseDate)
    )
    
    static let sakeDong = Recipe(
        id: UUID(),
        title: "스시로 만든 사케동",
        subTitle: "초간단 사케동 레시피",
        tags: [.init(name: "일식")],
        ingredientsGroups: [IngreidentGroup(
            title: "주재료",
            ingredients: [Ingredient(grocery: .init(name: "스시"), amount: 10, unit: .init(rawValue: "개")!),
                          Ingredient(grocery: .init(name: "양파"), amount: 1, unit: .init(rawValue: "개")!)])],
        cookingTime: 800,
        progress: [Step(index: 1, description: "스시를 시킨다", image: nil, time: 300, groceries: [Grocery(name: "스시")])],
        description: "이타다끼마스🍣",
        note: nil,
        serving: 1,
        image: nil,
        createdAt: baseDate,
        updatedAt:  Date(timeInterval: 500, since: baseDate)
    )
    
    static let creamSpaghetti = Recipe(
        id: UUID(),
        title: "크림 스파게티",
        subTitle: "냠냠",
        tags: [.init(name: "양식")],
        ingredientsGroups: [
            IngreidentGroup(
                title: "주재료",
                ingredients: [Ingredient(grocery: .init(name: "스파게티면"), amount: 500, unit: .init(rawValue: "g")!),
                              Ingredient(grocery: .init(name: "크림"), amount: 300, unit: .init(rawValue: "g")!)]),
            IngreidentGroup(
                title: "소스",
                ingredients: [Ingredient(grocery: .init(name: "크림"), amount: 100, unit: .init(rawValue: "g")!),
                              Ingredient(grocery: .init(name: "페퍼론치노"), amount: 30, unit: .init(rawValue: "g")!)])
            ],
        cookingTime: 800,
        progress: [Step(index: 1, description: "면을 삼는다", image: nil, time: 300, groceries: [Grocery(name: "스파게티면")])],
        description: "본아쁘띠🍝",
        note: nil,
        serving: 1,
        image: nil,
        createdAt: Date(),
        updatedAt: Date(timeInterval: 100, since: Date())
    )
}
