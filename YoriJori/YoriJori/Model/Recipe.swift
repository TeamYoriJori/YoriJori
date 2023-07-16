//
//  Recipe.swift
//  YoriJori
//
//  Created by forest on 2023/06/06.
//

import Foundation

struct Recipe {
    let id: UUID
    let title: String?
    let subTitle: String?
    let tags: [Tag]?
    let ingredientsGroups: [IngreidentGroup]?
    let cookingTime: Int?
    let progress: [Step]?
    let description: String?
    let note: String?
    let serving: Int?
    let image: Data?
    let createdAt: Date?
    let updatedAt: Date?
}

extension Recipe: Equatable {
    static func == (lhs: Recipe, rhs: Recipe) -> Bool {
        lhs.id == rhs.id
    }
}
