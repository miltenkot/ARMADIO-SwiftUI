//
//  TextStyle.swift
//  Armadio
//
//  Created by Bartłomiej on 27/10/2022.
//

import SwiftUI

struct TitleStyle: ViewModifier {
    let foregroundColor: Color
    
    init(foregroundColor: Color = Color.themeColor(.primaryText)) {
        self.foregroundColor = foregroundColor
    }
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: 30, weight: .bold))
            .foregroundColor(foregroundColor)
    }
}

struct NormalStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 18, weight: .medium))
            .foregroundColor(Color.themeColor(.primaryText))
    }
}

extension Text {
    func textStyle<Style: ViewModifier>(_ style: Style) -> some View {
        ModifiedContent(content: self, modifier: style)
    }
}
