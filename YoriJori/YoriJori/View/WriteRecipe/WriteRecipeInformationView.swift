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
    @State private var tags: [Tag] = [emptyTag, Tag("소주와 어울리는"), Tag("가벼운"), Tag("봄음식"), Tag("10분 요리")]
    @State private var recipeBook: String = ""
    @ObservedObject var image: PickableImageModel = PickableImageModel()
    
    @FocusState private var focusedField: Field?
    
    private static let emptyTag = Tag(.empty)
    
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
                            TextField("", text: $name, prompt: Text("요리 이름을 입력해주세요"))
                                .focused($focusedField, equals: .name)
                                .onSubmit { focusedField = .nickname }
                                .underline()
                            
                        })
                        VStack(alignment: .leading, content: {
                            Text("레시피 별명")
                            VStack(content: {
                                TextField("", text: $nickname, prompt: Text("요리의 별명을 만들어주세요"))
                                    .focused($focusedField, equals: .nickname)
                                    .onSubmit { focusedField = .tag }
                                    .underline()
                            })
                        })
                        VStack(alignment: .leading, content: {
                            Text("태그")
                            WrappingHStack(tags, id:\.self, spacing: .constant(6), lineSpacing: 6) { tag in
                                if (tag.name == .empty) {
                                    AddTagView(onTapped: addTag)
                                } else {
                                    TagView(name: tag.name, onClosed: deleteTag(name:))
                                }
                            }
                            .underline()
                        })
                        VStack(alignment: .leading, content: {
                            Text("레시피 북")
                            // TODO: 레시피 북 리스트에서 선택 가능하도록 변경
                            TextField("", text: $recipeBook, prompt: Text("아침"))
                                .focused($focusedField, equals: .recipeBook)
                                .underline()
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
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
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
                        .foregroundColor(.orange)
                        .font(.system(size: 14))
                })
            }
        }
    }
    
    struct AddTagView: View {
        @State private var tag: String = .empty
        let onTapped: () -> Void
        
        var body: some View {
            ZStack {
                HStack(alignment: .center, spacing: 4) {
                    TextField("", text: $tag, prompt: Text("태그"))
                        .frame(minWidth: 30)
                    Image(systemName: "plus")
                        .foregroundColor(.white)
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(RoundedRectangle(cornerRadius: 14).foregroundColor(.orange))
                .onTapGesture(perform: { onTapped() })
                .fixedSize(horizontal: true, vertical: false)
            }
        }
    }
    
}


#Preview {
    WriteRecipeInformationView(isOpen: .constant(false))
}
