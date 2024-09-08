//
//  RecipeInformationView.swift
//  YoriJori
//
//  Created by 예지 on 9/1/24.
//

import SwiftUI
import _PhotosUI_SwiftUI

struct RecipeInformationView: View {
    @State private var name: String = ""
    @State private var nickname: String = ""
    @State private var tag: String = ""
    @State private var recipeBook: String = ""
    @ObservedObject var image: PickableImageModel
    
    @FocusState private var focusedField: Field?
    
    enum Field: Hashable {
        case name
        case nickname
        case tag
        case recipeBook
    }
    
    var body: some View {
        ScrollView {
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
                        TextField("", text: $nickname, prompt: Text("#5분요리"))
                            .focused($focusedField, equals: .nickname)
                            .onSubmit { focusedField = .tag }
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.gray)
                    })
                })
                VStack(alignment: .leading, content: {
                    Text("태그")
                    VStack(content: {
                        TextField("", text: $tag, prompt: Text("요리 별명을 만들어주세요"))
                            .focused($focusedField, equals: .tag)
                            .onSubmit { focusedField = .recipeBook }
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.gray)
                    })
                })
                VStack(alignment: .leading, content: {
                    Text("레시피 북")
                    VStack(content: {
                        TextField("", text: $recipeBook, prompt: Text("아침"))
                            .focused($focusedField, equals: .recipeBook)
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.gray)
                    })
                })
                VStack(alignment: .leading, spacing: 8, content: {
                    HStack {
                        Text("대표 이미지")
                        Spacer()
                        PhotosPicker(selection: $image.imageSelection,
                                     matching: .images,
                                     photoLibrary: .shared()) {
                            Text( image.imageSelection == nil ? "선택하기": "다시 선택하기")
                                .foregroundColor(.orange)
                        }
                    }
                    GeometryReader(content: { geometry in
                        PhotoPickerImagePresenterView(imageState: image.imageState)
                            .frame(width: geometry.size.width, height: geometry.size.width * 3/4)
                            .background(.gray)
                    })
                })
            })
            .padding(.horizontal, 20)
        }
    }
}


#Preview {
    RecipeInformationView(image: PickableImageModel())
}
