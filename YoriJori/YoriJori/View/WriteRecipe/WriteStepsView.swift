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
    @State var steps: [Step] = [Step(index: 1, description: "먹기 좋은 크기로 자른다", image: nil, time: 5, groceries: [Grocery(name:"토마토")]), Step(index: 2, description: "올리브유에 볶는다올리브유에 볶는다올리브유에 볶는다올리브유에 볶는다올리브유에 볶는다올리브유에 볶는다올리브유에 볶는다올리브유에 볶는다올리브유에 볶는다올리브유에 볶는다올리브유에 볶는다올리브유에 볶는다올리브유에 볶는다올리브유에 볶는다올리브유에 볶는다올리브유에 볶는다올리브유에 볶는다올리브유에 볶는다올리브유에 볶는다올리브유에 볶는다올리브유에 볶는다올리브유에 볶는다올리브유에 볶는다올리브유에 볶는다", image: nil, time: 5, groceries: [Grocery(name:"토마토")])]
    
    var body: some View {
        VStack {
            StepProgressView(totalStepCount: 4, currnetStep: 3)
            HStack {
                Text("과정")
                    .font(.headline)
                Spacer()
            }.padding(EdgeInsets(top: 4, leading: 20, bottom: 4, trailing: 0))
            List {
                ForEach($steps, id: \.description){ step in
                    StepView(step: step)
                        .listRowInsets(EdgeInsets())
                        .background(Color.clear)
                }
            }
            .listStyle(PlainListStyle())
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

extension WriteStepsView {
    
    struct StepView: View {
        @Binding var step: Step
        
        var body: some View {
            VStack(content: {
                VStack(spacing: 0) {
                    HStack {
                        Text("STEP \(step.index)")
                        Spacer()
                        HStack {
                            Image(systemName: "clock")
                            // TODO: Measurement로 시간 representation 도구 만들기
                            Text("\(step.time!)")
                        }
                    }
                    .padding(12)
                    .background(.gray)
                    HStack(alignment: .top, spacing: 12) {
                        Rectangle()
                            .frame(width: 120, height: 90)
                        VStack(alignment: .leading) {
                            // TODO: 재료를 나열하는 함수를 구현한다
                            Text("재료쟂료재료")
                                .foregroundStyle(.gray)
                                .padding(.bottom, 12)
                            Text("\(String(describing: step.description!.lineBreakByCharWrapping))")
                            
                        }
                        Spacer()
                    }
                    .padding(16)
                }
            })
        }
    }
    
}

#Preview {
    WriteStepsView(isOpen: .constant(true))
}
