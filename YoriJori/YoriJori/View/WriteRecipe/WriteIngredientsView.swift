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
    
    @State private var isPresentingWriteIngredient: Bool = false
    @State private var serving : Int = 1
    @State private var ingredients: [Ingredient] = [Ingredient(grocery: Grocery(name: "토마토"), amount: nil, unit: .개)]
    // TODO: Util로 리팩토링
    private let numberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.maximumFractionDigits = 2
        return numberFormatter
    }()
    private let range = 1...100
    
    var body: some View {
        VStack {
            StepProgressView(totalStepCount: 4, currnetStep: 2)
            VStack {
                HStack {
                    Text(String(serving))
                        .foregroundStyle(.gray)
                        .bold()
                    Text("명을 위한 요리")
                    Spacer()
                    Stepper("", value: $serving, in: range)
                }
                // TODO: Header, Footer로 리팩터링
                List {
                    ForEach(ingredients, id: \.grocery.name){ ingredient in
                        let amount = numberFormatter.string(from: NSNumber(value: ingredient.amount ?? 0)) ?? ""
                        Text("\(ingredient.grocery.name) \(amount)\(String(describing: ingredient.unit!.rawValue))")
                            .listRowInsets(EdgeInsets())
                    }
                }
                .listStyle(.plain)
                Spacer()
                Button {
                    isPresentingWriteIngredient.toggle()
                } label: {
                    ZStack(content: {
                        RoundedRectangle(cornerRadius: 22.5)
                            .fill(.orange)
                            .frame(width: 160, height: 40)
                        Text("재료 추가")
                            .foregroundStyle(.white)
                    })
                }
                
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 8)
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
                    router.navigate(to: .writeSteps)
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
        .navigationBarBackButtonHidden()
        .sheet(isPresented: $isPresentingWriteIngredient, onDismiss: didDismiss, content: {
            WriteIngredientView(isPresenting: $isPresentingWriteIngredient)
        })
    }
    
    private func didDismiss() -> Void {
        isPresentingWriteIngredient = false
    }
    
}

#Preview {
    // TODO: Preview용 Router Initialilzer 구현
    WriteIngredientsView(isOpen: .constant(true))
}
