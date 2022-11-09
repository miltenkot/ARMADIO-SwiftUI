//
//  WardrobeViewModel.swift
//  Armadio
//
//  Created by Bartłomiej on 31/10/2022.
//

import Foundation
import SwiftUI

final class WardrobeViewModel: ObservableObject {
    @Published var categoryName: String = ""
    @Published var menuButtonExpanded: Bool = false
    @Published var isAddNewOpen = false
    @Published var isStatsOpen = false
    @Published var isOutfitsOpen = false
     
}
