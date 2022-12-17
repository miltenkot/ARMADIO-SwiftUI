//
//  ClothesListViewModel.swift
//  Armadio
//
//  Created by Bartłomiej on 27/11/2022.
//

import Foundation

/// Provide search query and selected property.
final class ClothesListViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var selectedProperty: ClotheProperty = .mostPopular
}
