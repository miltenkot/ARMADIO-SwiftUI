//
//  Shake.swift
//  Armadio
//
//  Created by Bartłomiej on 29/10/2022.
//

import SwiftUI

/// Modifier which provide shake the view.
struct Shake: AnimatableModifier {
    var shakes: CGFloat = 0
    
    /// requirements of AnimatableModifier we have to provide get and set
    var animatableData: CGFloat {
        get { shakes }
        set { shakes = newValue }
    }
    
    /// Perform shake animation by offset
    func body(content: Content) -> some View {
        ///shake the view once when the property gets increased by 1, twice when the property gets increased by 2, and so on.
        content
            .offset(x: sin(shakes * .pi * 2) * 5)
    }
}

extension View {
    func shake(with shakes: CGFloat) -> some View {
        modifier(Shake(shakes: shakes))
    }
}
