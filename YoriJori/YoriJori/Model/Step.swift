//
//  Step.swift
//  YoriJori
//
//  Created by forest on 2023/06/06.
//

import Foundation

struct Step {
    let index: Int
    let description: String?
    let image: Data?
    let time: Int?
    let groceries: [Grocery]?
}
