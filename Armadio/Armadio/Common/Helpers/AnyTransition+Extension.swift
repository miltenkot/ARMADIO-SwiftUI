//
//  AnyTransition+Extension.swift
//  Armadio
//
//  Created by Bartłomiej on 14/12/2022.
//

import SwiftUI

/// This remove temporary transparency during the animation.
/// SwiftUI performs a raw memory comparison of the active and identity NoOpTransition values, and it only runs the transition if there’s a difference.
extension AnyTransition {
    static let noOp: AnyTransition = .modifier(active: NoOpTransition(1), identity: NoOpTransition(0))
}

/// NoOp trainsition used as `AnyTransition` extension.
struct NoOpTransition: AnimatableModifier {
    var animatableData: CGFloat = 0
    
    init(_ x: CGFloat) {
        animatableData = x
    }
    
    func body(content: Content) -> some View {
        return content
    }
}
