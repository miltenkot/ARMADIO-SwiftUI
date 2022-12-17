//
//  UIApplication.swift
//  Armadio
//
//  Created by Bartłomiej on 04/12/2022.
//

import UIKit

/// Get the current key window.
extension UIApplication {
    static var keyWindow: UIWindow? {
        UIApplication.shared
            .connectedScenes.lazy
            .compactMap{ $0.activationState == .foregroundActive ? ($0 as? UIWindowScene) : nil }
            .first(where: { $0.keyWindow != nil })?
            .keyWindow
    }
}
