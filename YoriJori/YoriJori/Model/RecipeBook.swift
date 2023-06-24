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
    let recipes: [Recipe]?
}
