
//  Unit.swift
//  YoriJori
//
//  Created by forest on 2023/06/06.
//

import Foundation

enum Unit: String, CaseIterable, Identifiable {
    
    case kg
    case g
    case 개
    case none
    
    var id: String {
        switch self {
        case .kg:
            return self.rawValue
        case .g:
            return self.rawValue
        case .개:
            return self.rawValue
        case .none:
            return self.rawValue
        }
    }
}
