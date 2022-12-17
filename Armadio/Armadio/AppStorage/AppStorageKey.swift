//
//  AppStorageKey.swift
//  Armadio
//
//  Created by Bartłomiej on 15/12/2022.
//

import Foundation

/// Keys used by `AppStorage` to identify object.
enum AppStorageKey: String, CaseIterable {
    case avatarName
    case clotheTop
    case clotheMiddle
    case clotheBottom
    case clotheAccessories
    case clotheShoes
}
