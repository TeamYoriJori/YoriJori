//
//  RecipeBook.swift
//  YoriJori
//
//  Created by forest on 2023/06/06.
//

import Foundation

struct RecipeBook {
    let id: UUID
    let title: String?
    let image: Data?
    let updatedAt: Date
    let recipes: [Recipe]?
}

extension RecipeBook: Equatable {
    static func == (lhs: RecipeBook, rhs: RecipeBook) -> Bool {
        lhs.id == rhs.id
    }
}
