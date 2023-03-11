//
//  TextStyle.swift
//  Armadio
//
//  Created by Bartłomiej on 27/10/2022.
//

import SwiftUI

/// ViewModifier used to Titles.
struct TitleStyle: ViewModifier {
    let foregroundColor: Color
    let size: Double
    
    init(foregroundColor: Color = Color.themeColor(.primaryText), size: Double = 30) {
        self.foregroundColor = foregroundColor
        self.size = size
    }
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: size, weight: .bold))
            .foregroundColor(foregroundColor)
    }
}

extension ViewModifier where Self == TitleStyle {
    static func titleStyle(foregroundColor: Color, size: Double) -> Self { Self(foregroundColor: foregroundColor, size: size)
    }
}

struct TitleStyle_Preview: PreviewProvider {
    static var previews: some View {
        Text("Lorem ipsum")
            .textStyle(.titleStyle(foregroundColor: Color.black, size: 24))
            .previewLayout(.sizeThatFits)
        Text("Lorem ipsum")
            .textStyle(.titleStyle(foregroundColor: Color.red, size: 13))
            .previewLayout(.sizeThatFits)
    }
}

/// ViewModifier used to normal texts.
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
