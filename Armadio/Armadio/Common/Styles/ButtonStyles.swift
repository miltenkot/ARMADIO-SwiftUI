//
//  ButtonStyle.swift
//  Armadio
//
//  Created by Bartłomiej on 27/10/2022.
//

import SwiftUI

/// Button style with rounded corners.
struct RoundedButtonStyle: ButtonStyle {
    let foregroundColor: Color
    let backgroundColor: Color
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding()
            .foregroundColor(configuration.isPressed ? foregroundColor.opacity(0.3) : foregroundColor)
            .frame(maxWidth: 300)
            .background(backgroundColor)
            .cornerRadius(8)
            .padding([.top, .bottom], 10)
            .font(.system(size: 19, weight: .semibold))
    }
}

extension ButtonStyle where Self == RoundedButtonStyle {
    static func roundedButton(foregroundColor: Color, backgroundColor: Color) -> Self { Self(foregroundColor: foregroundColor, backgroundColor: backgroundColor)
    }
}

struct RoundedButtonStyle_Preview: PreviewProvider {
    static var previews: some View {
        Button(action: {
        }, label: {
            Text("Default")
        }).buttonStyle(.roundedButton(foregroundColor: .white, backgroundColor: .red)).padding().previewLayout(.sizeThatFits)
    }
}
