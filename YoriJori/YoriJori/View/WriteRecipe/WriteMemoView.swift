//
//  WriteMemoView.swift
//  YoriJori
//
//  Created by 예지 on 10/18/24.
//

import SwiftUI

struct WriteMemoView: View {
    @Binding var isOpen: Bool
    @StateObject var router = Router()
    
    @State var memo: String = ""
    
    init(isOpen: Binding<Bool>) {
        self._isOpen = isOpen
        if #available(iOS 17.0, *){
            UITextView.appearance().textContainerInset =
            UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
    
    var body: some View {
        NavigationStack(path: $router.navigationPath) {
            VStack(spacing: 0, content: {
                StepProgressView(totalStepCount: 4, currnetStep: 1)
                VStack(alignment: .leading, spacing: 8) {
                    Text("메모")
                    // TODO: Deployment Target 17로 변경
                    if #available(iOS 17.0, *) {
                        TextEditor(text: $memo)
                            .overlay(alignment: .topLeading) {
                                Text("요리에 대한 기억, 코멘트, 팁을 자유롭게 작성하세요")
                                    .foregroundStyle(memo.isEmpty ? .gray : .clear)
                                    .font(.body)
                                    .contentMargins(.top, 12)
                            }
                            .padding(8)
                            .scrollContentBackground(.hidden)
                            .frame(minHeight: 100, maxHeight: 400)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .border(.gray, width: 1)
                            .fixedSize(horizontal: false, vertical: true)
                         
                    } else {
                        TextEditor(text: $memo)
                            .overlay(alignment: .topLeading) {
                                Text("Placeholder")
                                    .foregroundStyle(memo.isEmpty ? .gray : .clear)
                                    .font(.body)
                            }
                            .padding(8)
                            .scrollContentBackground(.hidden)
                            .frame(minHeight: 100, maxHeight: 400)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .border(.gray, width: 1)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
                .padding(20)
                Spacer()
                HStack(content: {
                    Button { router.goBack()
                    } label: {
                        ZStack {
                            Rectangle()
                                .fill(.orange)
                                .frame(height: 64)
                            Text("과정 작성")
                                .foregroundStyle(.white)
                        }
                    }
                    Button {
                        
                    } label: {
                        ZStack {
                            Rectangle()
                                .fill(.yellow)
                                .frame(height: 64)
                            Text("레시피 저장")
                                .foregroundStyle(.white)
                        }
                    }
                })
            })
            .edgesIgnoringSafeArea(.bottom)
            .navigationDestination(for: WriteRecipeRoute.self) { route in
                switch route {
                case .writeIngredients:
                    WriteIngredientsView(router: router, isOpen: $isOpen)
                case .writeSteps:
                    WriteStepsView(router: router, isOpen: $isOpen)
                }
            }
            .navigationTitle("메모 작성")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        isOpen.toggle()
                    }, label: {
                        Text("닫기")
                            .foregroundStyle(.black)
                    })
                }
            }
        }
    }
}

#Preview {
    WriteMemoView(isOpen: .constant(true))
}
