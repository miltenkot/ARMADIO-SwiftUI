//
//  Color.swift
//  Armadio
//
//  Created by Bartłomiej on 28/10/2022.
//

import SwiftUI

/// A enum represents custom colors used in application.
enum ArmadioColor {
    case primaryText
    case primarySheet
    case primaryButtonBColor
    case primaryButtonFColor
    case primaryColor
}

extension Color {
    /// Gives access to the custom colors in the application.
    /// - Parameter type: all available custom colors inside enum `ArmadioColor`
    /// - Returns: color from assets
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

/// A enum represents custom gradients used in application.
enum ArmadioGradient {
    case primary
}

extension LinearGradient {
    /// Gives access to the custom gradients in the application.
    /// - Parameter type: all available custom gradients inside enum `ArmadioGradient`
    /// - Returns: `LinearGradient` from selected colors
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
