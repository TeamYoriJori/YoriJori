//
//  Ingredient.swift
//  YoriJori
//
//  Created by forest on 2023/06/06.
//

import Foundation

struct Ingredient {
    let grocery: Grocery
    let amount: Double?
    let unit: Unit?
}

extension Ingredient : Equatable {
    static func == (lhs: Ingredient, rhs: Ingredient) -> Bool {
        lhs.grocery.name == rhs.grocery.name
    }
}
