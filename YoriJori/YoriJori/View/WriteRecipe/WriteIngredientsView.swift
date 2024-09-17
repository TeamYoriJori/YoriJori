//
//  WriteIngredientsView.swift
//  YoriJori
//
//  Created by 예지 on 9/10/24.
//

import SwiftUI

struct WriteIngredientsView: View {
    // TODO: Environmnet로 주입
    @ObservedObject var router : Router = Router()
    
    var body: some View {
        NavigationStack(path: $router.navigationPath) {
            VStack {
                StepProgressView(totalStepCount: 4, currnetStep: 2)
            }
            .navigationTitle("재료 작성")
        }
    }
    
}

#Preview {
    // TODO: Preview용 Router Initialilzer 구현
    WriteIngredientsView()
}
