//
//  FilteredListView.swift
//  Armadio
//
//  Created by Bartłomiej on 15/11/2022.
//

import SwiftUI
import CoreData

struct FilteredListView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel = FilteredListViewModel()
    @Environment(\.managedObjectContext) var context
    @FetchRequest(sortDescriptors: [SortDescriptor(\Clothe.dateOfPurchase, order: .reverse)])
    private var clothes: FetchedResults<Clothe>
    @Binding var selectedClothe: LocalClothe?
    
    var query: Binding<String> {
        Binding {
            viewModel.searchText
        } set: { newValue in
            viewModel.searchText = newValue
            clothes.nsPredicate = newValue.isEmpty
            ? nil
            : NSPredicate(format: "%K BEGINSWITH %@ OR %K BEGINSWITH %@ OR %K BEGINSWITH %@ OR %K BEGINSWITH %@", argumentArray: [
                #keyPath(Clothe.category.name), newValue,
                #keyPath(Clothe.size), newValue,
                #keyPath(Clothe.brand), newValue,
                #keyPath(Clothe.material), newValue])
        }
    }
    
    var categories: [String: [Clothe]] {
        Dictionary(
            grouping: clothes,
            by: { $0.category?.name ?? "Category Name" }
        )
    }
    
    var body: some View {
        List {
            ForEach(categories.keys.shuffled(), id: \.self) { key in
                ClotheRow(categoryName: key, items: clothes, detailsAvailable: false) { clothe in
                    viewModel.updateClotheStats(clothe: clothe, for: context)
                    selectedClothe = LocalClothe.init(from: clothe)
                    dismiss()
                }
                .padding(.vertical)
            }
            .listRowInsets(EdgeInsets())
        }
        .searchable(text: query)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                SortMenu(selection: $viewModel.selectedSort)
                    .onChange(of: viewModel.selectedSort) { _ in
                        let sortBy = sorts[viewModel.selectedSort.index]
                        clothes.sortDescriptors = sortBy.descriptors
                    }
            }
        }
    }
}

struct FilteredListView_Previews: PreviewProvider {
    static var coreDataStack = CoreDataStack.preview
    static var previews: some View {
        FilteredListView(selectedClothe: .constant(nil))
            .environment(\.managedObjectContext, coreDataStack.container.viewContext)
    }
}
