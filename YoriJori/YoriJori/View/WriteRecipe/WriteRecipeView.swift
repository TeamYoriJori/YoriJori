//
//  WriteRecipeView.swift
//  YoriJori
//
//  Created by 예지 on 8/27/24.
//

import SwiftUI

struct WriteRecipeView: View {
    
    @State private var isPresentingWriteRecipe: Bool = false
    
    var body: some View {
        Button(action: {
            isPresentingWriteRecipe.toggle()
        }) {
            Text("Write New Recipe")
        }
        .fullScreenCover(isPresented: $isPresentingWriteRecipe,
                         onDismiss: didDismiss) {
            RecipeInformationView(image: PickableImageModel())
        }
    }
    
    private func didDismiss() -> Void {
        isPresentingWriteRecipe = false
    }
    
}

#Preview {
    WriteRecipeView()
}
