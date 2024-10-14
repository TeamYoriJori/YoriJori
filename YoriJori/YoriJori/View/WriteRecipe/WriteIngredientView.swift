//
//  WriteIngredientView.swift
//  YoriJori
//
//  Created by 예지 on 9/18/24.
//

import SwiftUI

// TODO: 팝업 형식으로 재구성
struct WriteIngredientView: View {
    
    @Binding var isPresenting: Bool
    @FocusState private var focusedField: Field?
    @State private var showPicker: Bool = false
    
    @State private var name: String = ""
    @State private var quanity: String = "1"
    @State private var unit: Unit = .개
    
    enum Field: Hashable {
        case name
        case quanity
        case unit
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 28) {
                Spacer()
                VStack(alignment: .center, content: {
                    Text("재료 이름")
                    TextField("", text: $name, prompt: Text("재료 이름을 입력해주세요"))
                        .multilineTextAlignment(.center)
                        .focused($focusedField, equals: .name)
                        .onSubmit { focusedField = .quanity }
                        .underline()
                })
                .padding([.horizontal], 20)
                HStack(alignment: .bottom){
                    VStack(alignment: .center, spacing: 6, content: {
                        Text("양")
                        TextField("", text: $quanity, prompt: Text(""))
                            .multilineTextAlignment(.center)
                            .keyboardType(.numberPad)
                            .focused($focusedField, equals: .quanity)
                            .onSubmit { focusedField = .unit }
                            .underline()
                    })
                    VStack(alignment: .center, spacing: 0 ,content: {
                        Text("단위")
                        Picker("Select a unit", selection: $unit) {
                            ForEach(Unit.allCases) { unit in
                                Text(unit.rawValue).tag(unit)
                            }
                        }
                        .pickerStyle(.menu)
                        .tint(.orange)
                        .underline()
                    })
                }
                .padding([.horizontal], 20)
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
            .edgesIgnoringSafeArea(.bottom)
            .navigationTitle("재료 추가")
            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
}

#Preview {
    WriteIngredientView(isPresenting: .constant(true))
}
