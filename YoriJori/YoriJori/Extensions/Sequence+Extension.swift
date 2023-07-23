//
//  Sequence+Extension.swift
//  YoriJori
//
//  Created by moon Lily on 2023/07/23.
//

import Foundation

extension Sequence where Element: Hashable {
    func removeDuplicate() -> [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
}
