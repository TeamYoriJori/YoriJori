//
//  RecipeBook.swift
//  YoriJori
//
//  Created by forest on 2023/06/06.
//

import Foundation

struct RecipeBook {
    let id: UUID
    var title: String?
    var image: Data?
    var updatedAt: Date
    var recipes: [Recipe]?
}

extension RecipeBook: Equatable {
    static func == (lhs: RecipeBook, rhs: RecipeBook) -> Bool {
        lhs.id == rhs.id
    }
}
