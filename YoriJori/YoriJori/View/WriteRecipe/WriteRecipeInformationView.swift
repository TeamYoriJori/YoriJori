//
//  RecipeInformationView.swift
//  YoriJori
//
//  Created by 예지 on 9/1/24.
//

import SwiftUI
import _PhotosUI_SwiftUI
import WrappingHStack

struct WriteRecipeInformationView: View {
    
    @Binding var isOpen: Bool
    @StateObject private var router = Router()
    
    @State private var name: String = ""
    @State private var nickname: String = ""
    @State private var tags: [String] = ["소주와 어울리는", "가벼운", "봄음식", "10분 요리"]
    @State private var recipeBook: String = ""
    @ObservedObject var image: PickableImageModel = PickableImageModel()
    
    @FocusState private var focusedField: Field?
    
    private static let emptyTag = Tag(name: "")
    
    enum Field: Hashable {
        case name
        case nickname
        case tag
        case recipeBook
    }
    
    var body: some View {
        NavigationStack(path: $router.navigationPath) {
            VStack(spacing: 0, content: {
                StepProgressView(totalStepCount: 4, currnetStep: 1)
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
                        // TODO: 레시피 별명 태그 Component로 구현
                        VStack(alignment: .leading, content: {
                            Text("레시피 별명")
                            VStack(content: {
                                TextField("", text: $nickname, prompt: Text("요리의 별명을 만들어주세요"))
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
//                                TextField("", text: $tag, prompt: Text("요리 별명을 만들어주세요"))
//                                    .focused($focusedField, equals: .tag)
//                                    .onSubmit { focusedField = .recipeBook }
                                WrappingHStack(tags, id:\.self, spacing: .constant(6), lineSpacing: 6) { tag in
                                    if (tag == .empty) {
                                        AddTagView(onTapped: addTag)
                                    } else {
                                        TagView(name: tag, onClosed: deleteTag(name:))
                                    }
                                }
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
                            // TODO: AutoLayout으로 리팩터링
                            GeometryReader(content: { geometry in
                                PhotoPickerImagePresenterView(imageState: image.imageState)
                                    .frame(width: geometry.size.width, height: geometry.size.width * 3/4)
                                    .background(.gray)
                            })
                        })
                    })
                    .padding([.horizontal, .top], 20)
                }
                Button {
                    router.navigate(to: .writeIngredients)
                } label: {
                    ZStack {
                        Rectangle()
                            .fill(.orange)
                            .frame(height: 64)
                        Text("요리 재료 작성")
                            .foregroundStyle(.white)
                    }
                }
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
            .navigationTitle("요리 정보 작성")
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
    
    private func addTag() -> Void {
        
    }
    
    private func deleteTag(name: String) -> Void {
        
    }
}

extension WriteRecipeInformationView {
    
    struct TagView: View {
        let name: String
        let onClosed: (String) -> Void
        
        var body: some View {
            HStack(alignment: .center, spacing: 4) {
                Text("#\(name)")
                Button(action: {onClosed(name)}, label: {
                    Image(systemName: "xmark")
                        .foregroundColor(.black)
                })
            }
        }
    }
    
    struct AddTagView: View {
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
    
}


#Preview {
    WriteRecipeInformationView(isOpen: .constant(false))
}
