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
    
}

extension WriteRecipeRoute {
    
    static func view(of route: WriteRecipeRoute, isOpen: Binding<Bool>, _ router: Router) -> some View {
        switch route {
        case .writeIngredients:
            return WriteIngredientsView(router: router, isOpen: isOpen)
        }
    }
    
}
