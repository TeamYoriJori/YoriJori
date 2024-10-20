//
//  Recipe.swift
//  YoriJori
//
//  Created by forest on 2023/06/06.
//

import Foundation

struct Recipe {
    let id: UUID
    var recipeBookID: UUID?
    var title: String?
    var subTitle: String?
    var tags: [Tag]?
    var ingredientsGroups: [IngreidentGroup]?
    var cookingTime: Int?
    var progress: [Step]?
    var description: String?
    var note: String?
    var serving: Int?
    var image: Data?
    var createdAt: Date
    var updatedAt: Date
}

extension Recipe: Equatable {
    static func == (lhs: Recipe, rhs: Recipe) -> Bool {
        lhs.id == rhs.id
    }
}
