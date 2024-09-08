//
//  RecipeImageView.swift
//  YoriJori
//
//  Created by 예지 on 9/6/24.
//

import SwiftUI

struct PhotoPickerImagePresenterView: View {
    let imageState: PickableImageModel.ImageState
    
    var body: some View {
        switch imageState {
        case .success(let image):
            image.resizable()
        case .loading:
            ProgressView()
        case .empty:
            Image(systemName: "photo.fill")
                .font(.system(size: 40))
                .foregroundColor(.white)
        case .failure:
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 40))
                .foregroundColor(.white)
        }
    }
}

#Preview {
    PhotoPickerImagePresenterView(imageState: .empty)
}
