//
//  Color.swift
//  Armadio
//
//  Created by Bartłomiej on 28/10/2022.
//

import SwiftUI

enum ArmadioColor {
    case primaryText
    case primarySheet
    case primaryButtonBColor
    case primaryButtonFColor
    case primaryColor
}

extension Color {
    static func themeColor(_ type: ArmadioColor) -> Color {
        switch type {
        case .primaryText: return Color("PrimaryTextColor")
        case .primarySheet: return Color("PrimarySheetColor")
        case .primaryButtonBColor: return Color("PrimaryButtonBColor")
        case .primaryButtonFColor: return Color("PrimaryButtonFColor")
        case .primaryColor: return Color("PrimaryColor")
        }
    }
}

enum ArmadioGradient {
    case primary
}

extension LinearGradient {
    static func gradient(_ type: ArmadioGradient) -> LinearGradient {
        switch type {
        case .primary:
            return LinearGradient(colors: [.blue.opacity(0.5),
                                           .red.opacity(0.2),
                                           .purple.opacity(0.05)],
                                  startPoint: .top,
                                  endPoint: .bottom)
        }
    }
}
