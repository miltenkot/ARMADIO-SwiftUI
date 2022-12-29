//
//  WardrobeViewModel.swift
//  Armadio
//
//  Created by Bartłomiej on 31/10/2022.
//

import Foundation
import SwiftUI

/// Provide module navigation around `AddNew`, `Stats` and `List` views.
final class WardrobeViewModel: ObservableObject {
    @Published var categoryName: String = ""
    @Published var menuButtonExpanded: Bool = false
    @Published var isAddNewOpen = false
    @Published var isStatsOpen = false
    @Published var isOutfitsOpen = false
    @Published var isListOpen = false
    @Published var activeModalView: ModalView? = nil
    
    enum ModalView: String, Identifiable {
        case addNew, stats, list
        
        var id: String {
            return self.rawValue
        }
    }
}
