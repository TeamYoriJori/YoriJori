//
//  RecipeInformationViewModel.swift
//  YoriJori
//
//  Created by 예지 on 9/1/24.
//

import Foundation
import UIKit

struct RecipeInformationViewModel {
    
    var name: String?
    var nickname: String?
    var tags: [String] = []
    var recipeBookName: String?
    var image: UIImage?
    
    func closeClicked() -> Void {}
    func nextClicked() -> Void {}
}
