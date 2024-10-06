//
//  WriteStepsView.swift
//  YoriJori
//
//  Created by 예지 on 9/22/24.
//

import SwiftUI

struct WriteStepsView: View {
    @ObservedObject var router : Router = Router()
    @Binding var isOpen: Bool
    @State private var isPresentingWriteStep: Bool = false
    
    var body: some View {
        VStack {
            StepProgressView(totalStepCount: 4, currnetStep: 3)
            Spacer()
            Button {
                isPresentingWriteStep.toggle()
            } label: {
                ZStack(content: {
                    RoundedRectangle(cornerRadius: 22.5)
                        .fill(.orange)
                        .frame(width: 160, height: 40)
                    // TODO: 자동으로 STEP 숫자 증가 기능 추가
                    Text("STEP 추가")
                        .foregroundStyle(.white)
                })
            }
            HStack(content: {
                Button { router.goBack()
                } label: {
                    ZStack {
                        Rectangle()
                            .fill(.orange)
                            .frame(height: 64)
                        Text("재료 작성")
                            .foregroundStyle(.white)
                    }
                }
                Button {
                    
                } label: {
                    ZStack {
                        Rectangle()
                            .fill(.orange)
                            .frame(height: 64)
                        Text("메모 작성")
                            .foregroundStyle(.white)
                    }
                }
            })
        }
        .edgesIgnoringSafeArea(.bottom)
        .navigationTitle("요리 과정 작성")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: { isOpen.toggle() },
                       label: { Text("닫기").foregroundStyle(.black) })
            }
        }
        .sheet(isPresented: $isPresentingWriteStep, onDismiss: didDismiss, content: {
            WriteStepView(isPresenting: $isPresentingWriteStep, index: 1)
        })
    }
    
    private func didDismiss() -> Void {
        isPresentingWriteStep = false
    }
}

#Preview {
    WriteStepsView(isOpen: .constant(true))
}
