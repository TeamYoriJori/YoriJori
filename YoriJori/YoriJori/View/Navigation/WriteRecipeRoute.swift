//
//  Route.swift
//  YoriJori
//
//  Created by 예지 on 9/17/24.
//

import Foundation
import SwiftUI

enum WriteRecipeRoute: Hashable {
    
    case writeIngredients
    case writeSteps
    case writeMemo
    
}

extension WriteRecipeRoute {
    
    // TODO: 삭제 후 다른 방법 모색
    static func view(of route: WriteRecipeRoute, isOpen: Binding<Bool>, _ router: Router) -> some View {
        switch route {
        case .writeIngredients:
            return WriteIngredientsView(router: router, isOpen: isOpen)
        default:
            return WriteIngredientsView(router: router, isOpen: isOpen)
        }
    }
    
}
