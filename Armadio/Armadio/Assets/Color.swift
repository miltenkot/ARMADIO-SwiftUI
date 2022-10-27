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
}

extension Color {
    static func themeColor(_ type: ArmadioColor) -> Color {
        switch type {
        case .primaryText: return Color("PrimaryTextColor")
        case .primarySheet: return Color("PrimarySheetColor")
        case .primaryButtonBColor: return Color("PrimaryButtonBColor")
        case .primaryButtonFColor: return Color("PrimaryButtonFColor")
        }
    }
}
