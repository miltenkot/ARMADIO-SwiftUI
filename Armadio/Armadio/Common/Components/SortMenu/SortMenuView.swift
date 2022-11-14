//
//  SortMenuView.swift
//  Armadio
//
//  Created by Bartłomiej on 16/11/2022.
//

import SwiftUI

let sorts = [
    (
        name: "Time",
        descriptors: [SortDescriptor(\Clothe.dateOfPurchase, order: .reverse)]
    ),
    (
        name: "Time",
        descriptors: [SortDescriptor(\Clothe.dateOfPurchase, order: .forward)]
    ),
    (
        name: "Size",
        descriptors: [SortDescriptor(\Clothe.size, order: .reverse)]
    ),
    (
        name: "Size",
        descriptors: [SortDescriptor(\Clothe.size, order: .forward)]
    )
]

struct SortMenu: View {
    @Binding private var selectedSort: SelectedSort
    
    init(selection: Binding<SelectedSort>) {
        _selectedSort = selection
    }
    var body: some View {
        Menu {
            Picker("Sort By", selection: $selectedSort.by) {
                ForEach(Array(stride(from: 0, to: sorts.count, by: 2)), id: \.self) { index in
                    Text(sorts[index].name).tag(index)
                }
            }
            Picker("Sort Order", selection: $selectedSort.order) {
                let sortBy = sorts[selectedSort.by + selectedSort.order]
                let sortOrders = sortOrders(for: sortBy.name)
                ForEach(0..<sortOrders.count, id: \.self) { index in
                    Text(sortOrders[index]).tag(index)
                }
            }
        } label: {
            Label("More", systemImage: "ellipsis.circle")
        }
        .pickerStyle(InlinePickerStyle())
    }
    private func sortOrders(for name: String) -> [String] {
        switch name {
        case "Size":
            return ["Highest to Lowest", "Lowest to Highest"]
        case "Time":
            return ["Newest on Top", "Oldest on Top"]
        default:
            return []
        }
    }
}

struct SortMenu_Previews: PreviewProvider {
    static var previews: some View {
        SortMenu(selection: .constant(.init(by: 0, order: 0)))
    }
}
