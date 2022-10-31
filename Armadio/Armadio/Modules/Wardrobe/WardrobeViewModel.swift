//
//  WardrobeViewModel.swift
//  Armadio
//
//  Created by Bartłomiej on 31/10/2022.
//

import Foundation

final class WardrobeViewModel: ObservableObject {
    @Published var clothes: [Clothe] = Clothe.clothesMock // load from persist
    @Published var categoryName: String = ""
    
    var categories: [String: [Clothe]] {
        Dictionary(
            grouping: clothes,
            by: { $0.category.rawValue }
        )
    }
    
    
}
