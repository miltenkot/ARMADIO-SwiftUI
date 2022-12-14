//
//  AnyTransition+Extension.swift
//  Armadio
//
//  Created by Bartłomiej on 14/12/2022.
//

import SwiftUI

extension AnyTransition {
    static let noOp: AnyTransition = .modifier(active: NoOpTransition(1), identity: NoOpTransition(0))
}

struct NoOpTransition: AnimatableModifier {
    var animatableData: CGFloat = 0
    
    init(_ x: CGFloat) {
        animatableData = x
    }
    
    func body(content: Content) -> some View {
        return content
    }
}
