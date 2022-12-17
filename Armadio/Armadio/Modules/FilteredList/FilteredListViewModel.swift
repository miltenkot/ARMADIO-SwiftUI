//
//  FilteredListViewModel.swift
//  Armadio
//
//  Created by Bartłomiej on 16/11/2022.
//

import Foundation
import CoreData
import Factory

/// Provide sorting selection.
struct SelectedSort: Equatable {
    var by = 0
    var order = 0
    var index: Int { by + order }
}

/// Provide update clothe wear stats.
final class FilteredListViewModel: ObservableObject {
    @Injected(Container.clotheDataProvider) private var clotheDataProvider
    @Published var selectedSort = SelectedSort()
    @Published var searchText = ""
    
    func updateClotheStats(clothe: Clothe, for context: NSManagedObjectContext) {
        clotheDataProvider.updateClotheStats(clothe: clothe, coreDataContext: context)
    }
}
