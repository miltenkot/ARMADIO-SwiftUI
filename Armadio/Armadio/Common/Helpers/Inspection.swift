//
//  Inspection.swift
//  Armadio
//
//  Created by Bartłomiej on 27/10/2022.
//

import Combine
import SwiftUI


/// Create an object that allows ViewInspector to trigger changes in your view at any point — such as on didAppear or one second after the view appears when an animation has finished.
internal final class Inspection<V> {
    let notice = PassthroughSubject<UInt, Never>()
    var callbacks: [UInt: (V) -> Void] = [:]
    
    func visit(_ view: V, _ line: UInt) {
        if let callback = callbacks.removeValue(forKey: line) {
            callback(view)
        }
    }
}
