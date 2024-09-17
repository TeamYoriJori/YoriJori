//
//  Router.swift
//  YoriJori
//
//  Created by 예지 on 9/17/24.
//

import Foundation
import SwiftUI

final class Router : ObservableObject {
    
    @Published var navigationPath = NavigationPath()
    
    func navigate(to destination: Route) -> Void {
        navigationPath.append(destination)
    }
    
    func view(of route: Route) -> some View {
        switch route {
        case .writeIngredients:
            return WriteIngredientsView()
        }
    }
    
}
