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
    @Binding var isOpen: Bool 
    
    var body: some View {
        NavigationStack(path: $router.navigationPath) {
            VStack {
                StepProgressView(totalStepCount: 4, currnetStep: 2)
                Spacer()
                HStack(content: {
                    Button { router.goBack()
                    } label: {
                        ZStack {
                            Rectangle()
                                .fill(.orange)
                                .frame(height: 64)
                            Text("정보 작성")
                                .foregroundStyle(.white)
                        }
                    }
                    Button {
                        
                    } label: {
                        ZStack {
                            Rectangle()
                                .fill(.orange)
                                .frame(height: 64)
                            Text("스텝 작성")
                                .foregroundStyle(.white)
                        }
                    }


                })
            }
            .edgesIgnoringSafeArea(.bottom)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: { isOpen.toggle() },
                           label: { Text("닫기").foregroundStyle(.black) })
                }
            }
            .navigationTitle("재료 작성")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
}

#Preview {
    // TODO: Preview용 Router Initialilzer 구현
    WriteIngredientsView(isOpen: .constant(true))
}
