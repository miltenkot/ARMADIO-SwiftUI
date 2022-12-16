//
//  User.swift
//  Armadio
//
//  Created by Bartłomiej on 13/12/2022.
//

import Foundation

struct UserInfo: Codable {
    var uid: String?
    var email: String?
    var displayName: String?
    var phoneNumber: String?
    var photo: URL?
}
