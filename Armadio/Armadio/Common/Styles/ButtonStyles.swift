//
//  ButtonStyle.swift
//  Armadio
//
//  Created by Bartłomiej on 27/10/2022.
//

import SwiftUI

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
