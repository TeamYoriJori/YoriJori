//
//  RecipeInformationView.swift
//  YoriJori
//
//  Created by 예지 on 9/1/24.
//

import SwiftUI

struct RecipeInformationView: View {
    @State private var name: String = ""
    @FocusState private var focusedField: Field?
    
    enum Field: Hashable {
        case name
        case nickname
        case tag
        case recipeBook
    }
    
    var body: some View {
        VStack(spacing: 28, content: {
            VStack(alignment: .leading, content: {
                Text("레시피 이름")
                VStack(content: {
                    TextField("", text: $name, prompt: Text("요리 이름을 입력해주세요"))
                        .focused($focusedField, equals: .name)
                        .onSubmit { focusedField = .nickname }
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.gray)
                })
            })
            VStack(alignment: .leading, content: {
                Text("레시피 별명")
                VStack(content: {
                    TextField("", text: $name, prompt: Text("#5분요리"))
                        .focused($focusedField, equals: .tag)
                        .onSubmit { focusedField = .recipeBook }
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.gray)
                })
            })
            VStack(alignment: .leading, content: {
                Text("태그")
                VStack(content: {
                    TextField("", text: $name, prompt: Text("요리 별명을 만들어주세요"))
                        .focused($focusedField, equals: .nickname)
                        .onSubmit { focusedField = .tag }
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.gray)
                })
            })
            VStack(alignment: .leading, content: {
                Text("레시피 북")
                VStack(content: {
                    TextField("", text: $name, prompt: Text("아침"))
                        .focused($focusedField, equals: .recipeBook)
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.gray)
                })
            })
            VStack(alignment: .leading, content: {
                Text("대표 이미지")
                TextField("", text: $name, prompt: Text("요리 이름을 입력해주세요"))
            })
        })
        .padding(.horizontal, 20)
    }
}


#Preview {
    RecipeInformationView()
}
