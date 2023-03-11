//
//  User.swift
//  Armadio
//
//  Created by Bartłomiej on 13/12/2022.
//

import Foundation

/// A struct conforming to `Codable` authenticated user info.
struct UserInfo {
    var uid: String?
    var email: String?
    var displayName: String?
    var phoneNumber: String?
    var photo: URL?
}
