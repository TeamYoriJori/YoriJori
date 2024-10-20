//
//  Step.swift
//  YoriJori
//
//  Created by forest on 2023/06/06.
//

import Foundation

struct Step {
    // TODO: UUID 필요 여부 검토하고 추가한다
    var index: Int
    var description: String?
    var image: Data?
    var time: Int?
    var groceries: [Grocery]?
}
