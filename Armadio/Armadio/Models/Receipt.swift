//
//  Receipt.swift
//  Armadio
//
//  Created by Bartłomiej on 31/10/2022.
//

import Foundation
import SwiftUI

struct Receipt: Hashable, Codable, Identifiable {
    var id: Int
    
    private var imageName: String
    var image: Image {
        Image(imageName)
    }
}
