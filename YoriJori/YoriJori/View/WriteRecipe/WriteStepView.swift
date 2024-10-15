//
//  WriteStepView.swift
//  YoriJori
//
//  Created by 예지 on 10/3/24.
//

import SwiftUI
import _PhotosUI_SwiftUI
import WrappingHStack

struct WriteStepView: View {
    
    @Binding var isPresenting: Bool
    
    @ObservedObject private var image: PickableImageModel = PickableImageModel()
    private var index: Int
    @State private var seconds: String = "0"
    @State private var minute: String = "0"
    @State private var hour: String = "0"
    // TODO: 재료는 한 번만 선택 가능하고, 선택하면 후보에서 사라진다.
    @State private var ingredients: [Ingredient] = [emptyIngredient, Ingredient(grocery: Grocery(name: "토마토"), amount: 3, unit: .개),Ingredient(grocery: Grocery(name: "오일"), amount: 3, unit: .개), Ingredient(grocery: Grocery(name: "브로콜리"), amount: 3, unit: .개),Ingredient(grocery: Grocery(name: "파스타면"), amount: 3, unit: .개)]
    @State private var selcetableIngredients: [Ingredient] = [Ingredient(grocery: Grocery(name: "토마토"), amount: 3, unit: .개),Ingredient(grocery: Grocery(name: "오일"), amount: 3, unit: .개), Ingredient(grocery: Grocery(name: "브로콜리"), amount: 3, unit: .개),Ingredient(grocery: Grocery(name: "파스타면"), amount: 3, unit: .개)]
    @State private var description: String = "dddd"
    @State private var isingredientMenuHidden: Bool = true
    
    private static let emptyIngredient = Ingredient(grocery: Grocery(name: ""), amount: nil, unit: nil)
    
    init(isPresenting: Binding<Bool>, index: Int) {
        self._isPresenting = isPresenting
        self.index = index
    }
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomLeading, content: {
                VStack {
                    // TODO: 스크롤영역 버튼에 안가리도록 수정
                    ScrollView {
                        VStack(alignment: .leading, spacing: 28) {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("요리 시간")
                                HStack(alignment: .bottom, spacing: 4) {
                                    TimeInputView(numericTime: $hour, timeUnit: "시간")
                                    TimeInputView(numericTime: $hour, timeUnit: "분")
                                    TimeInputView(numericTime: $hour, timeUnit: "초")
                                }
                            }
                            VStack(alignment: .leading, spacing: 8) {
                                Text("필요한 재료")
                                WrappingHStack(ingredients, id:\.self, spacing: .constant(6), lineSpacing: 6) { ingredient in
                                    if (ingredient == WriteStepView.emptyIngredient) {
                                        AddIngredientView(onTapped: addIngredient)
                                    } else {
                                        IngredientView(name: ingredient.grocery.name,
                                                       onClosed: deleteIngredient(name:))
                                    }
                                }
                            }
                            VStack(alignment: .leading, spacing: 8) {
                                Text("요리 방법")
                                TextEditor(text: $description)
                                    .padding(8)
                                    .scrollContentBackground(.hidden)
                                    .frame(minHeight: 100)
                                    .background(Color.yellow)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                            }
                            VStack(alignment: .leading, spacing: 8, content: {
                                HStack {
                                    Text("사진")
                                    Spacer()
                                    PhotosPicker(selection: $image.imageSelection,
                                                 matching: .images,
                                                 photoLibrary: .shared()) {
                                        Text( image.imageSelection == nil ? "선택하기": "다시 선택하기")
                                            .foregroundColor(.orange)
                                    }
                                }
                                // TODO: AutoLayout으로 리팩터링
                                GeometryReader(content: { geometry in
                                    PhotoPickerImagePresenterView(imageState: image.imageState)
                                        .frame(width: geometry.size.width, height: geometry.size.width * 3/4)
                                        .background(.gray)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                })
                            })
                        }
                    }
                    .padding([.horizontal, .top], 20)
                    
                    Spacer()
                    
                    Button(action: {
                        isPresenting = false
                    }, label: {
                        ZStack {
                            Rectangle()
                                .fill(.orange)
                                .frame(height: 64)
                            Text("저장")
                                .foregroundStyle(.white)
                        }
                    })
                }
                
                IngredientMenuView(
                    ingredients: $selcetableIngredients, onSelected: selectIngredient(ingredient:), onCloseButtonClicked: {isingredientMenuHidden = true})
                .isHidden($isingredientMenuHidden)
            })
            .edgesIgnoringSafeArea(.bottom)
            .navigationTitle("과정 \(index.description)")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func addIngredient() -> Void {
        if (isingredientMenuHidden == true) {
            isingredientMenuHidden = false
        }
    }
    
    private func deleteIngredient(name: String) -> Void {
        
    }
    
    private func selectIngredient(ingredient: Ingredient) -> Void {
        
    }
    
}

extension WriteStepView {
    
    struct TimeInputView: View {
        @Binding var inputValue: String
        // TODO: Measurement로 리팩터링
        var timeUnit: String = ""
        
        init(numericTime: Binding<String>, timeUnit: String) {
            self._inputValue = numericTime
            self.timeUnit = timeUnit
        }
        
        var body: some View {
            HStack(alignment: .bottom){
                HStack(alignment: .center, spacing: 6, content: {
                    TextField("", text: $inputValue)
                        .multilineTextAlignment(.center)
                        .keyboardType(.numberPad)
                        .underline()
                    Text(timeUnit)
                })
            }
        }
    }
    
    struct IngredientView: View {
        let name: String
        let onClosed: (String) -> Void
        
        var body: some View {
            ZStack {
                HStack(alignment: .center, spacing: 4) {
                    Text(name)
                    Button(action: {onClosed(name)}, label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.black)
                    })
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(RoundedRectangle(cornerRadius: 14).foregroundColor(.green))
            }
        }
    }
    
    struct AddIngredientView: View {
        let onTapped: () -> Void
        
        var body: some View {
            ZStack {
                HStack(alignment: .center, spacing: 4) {
                    Text("추가하기")
                    Image(systemName: "plus")
                        .foregroundColor(.black)
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(RoundedRectangle(cornerRadius: 14).foregroundColor(.orange))
                .onTapGesture(perform: { onTapped() })
            }
        }
    }
    
    // TODO: 포커스 변경에 따라 뷰 Hidden 처리 구현
    struct IngredientMenuView: View {
        
        @Binding var ingredients: [Ingredient]
        var onSelected: (Ingredient) -> Void
        var onCloseButtonClicked: () -> Void
        
        var body: some View {
            ZStack(alignment: .topTrailing, content: {
                VStack(alignment: .leading, content: {
                    Text("재료를 골라주세요")
                    WrappingHStack(ingredients, id:\.self, spacing: .constant(6), lineSpacing: 6) { ingredient in
                        Button(action: {onSelected(ingredient)}, label: {
                            Text(ingredient.grocery.name)
                                .foregroundStyle(.white)
                        })
                        .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
                        .background(RoundedRectangle(cornerRadius: 14).foregroundStyle(.yellow))
                    }
                })
                .padding(EdgeInsets(top: 16, leading: 20, bottom: 40, trailing: 20))
                .background(.gray)
                Button {
                    onCloseButtonClicked()
                } label: {
                    Image(systemName:"xmark")
                        .foregroundColor(.white)
                }
                .padding(8)
            })
        }
    }
    
}

#Preview {
    WriteStepView(isPresenting: .constant(true), index: 1)
}
