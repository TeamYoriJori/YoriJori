//
//  WriteStepView.swift
//  YoriJori
//
//  Created by 예지 on 10/3/24.
//

import SwiftUI
import _PhotosUI_SwiftUI

struct WriteStepView: View {
    
    @Binding var isPresenting: Bool
    
    @ObservedObject private var image: PickableImageModel = PickableImageModel()
    private var index: Int
    @State private var seconds: String = "0"
    @State private var minute: String = "0"
    @State private var hour: String = "0"
    
    init(isPresenting: Binding<Bool>, index: Int) {
        self._isPresenting = isPresenting
        self.index = index
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack(alignment: .leading, spacing: 28) {
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
                        })
                    })
                    VStack(alignment: .leading, spacing: 8) {
                        Text("요리 시간")
                        HStack(alignment: .bottom, spacing: 4) {
                            TimeView(numericTime: $hour, timeUnit: "시간")
                            TimeView(numericTime: $hour, timeUnit: "분")
                            TimeView(numericTime: $hour, timeUnit: "초")
                        }
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
            .edgesIgnoringSafeArea(.bottom)
            .navigationTitle("과정 \(index.description)")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
}

extension WriteStepView {
    
    struct TimeView: View {
        @Binding var numericValue: String
        var timeUnit: String = ""
        
        init(numericTime: Binding<String>, timeUnit: String) {
            self._numericValue = numericTime
            self.timeUnit = timeUnit
        }
        
        var body: some View {
            HStack(alignment: .bottom){
                HStack(alignment: .center, spacing: 6, content: {
                    VStack(content: {
                        TextField("", text: $numericValue)
                            .multilineTextAlignment(.center)
                            .keyboardType(.numberPad)
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.gray)
                    })
                    // TODO: Measurement로 리팩터링
                    Text(timeUnit)
                })
            }
        }
    }
    
}

#Preview {
    WriteStepView(isPresenting: .constant(true), index: 1)
}
