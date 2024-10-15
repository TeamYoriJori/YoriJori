//
//  IsHiddenViewModifier.swift
//  YoriJori
//
//  Created by 예지 on 10/15/24.
//

import SwiftUI

struct HiddenModifier: ViewModifier {
    @Binding var isHidden: Bool
    
    func body(content: Content) -> some View {
        Group {
            if isHidden {
                content.hidden()
            } else {
                content
            }
        }
    }
}

extension View {
    func isHidden(_ hidden: Binding<Bool>) -> some View {
        modifier(HiddenModifier(isHidden: hidden))
    }
}
