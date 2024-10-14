//
//  UnderlineTextFieldModifier.swift
//  YoriJori
//
//  Created by 예지 on 10/14/24.
//

import SwiftUI

struct UnderlineViewModifier: ViewModifier {
    var color: Color = .gray
    var lineHeight: CGFloat = 1
    
    func body(content: Content) -> some View {
        content
            .padding(.bottom, 8)
            .overlay(
                Rectangle()
                    .frame(height: lineHeight)
                    .foregroundColor(color),
                alignment: .bottom
            )
    }
}

extension View {
    
    func underline(color: Color = .gray, lineHeight: CGFloat = 1) -> some View {
        self.modifier(UnderlineViewModifier(color: color, lineHeight: lineHeight))
    }
    
}
