//
//  ClothesListView.swift
//  Armadio
//
//  Created by Bartłomiej on 27/11/2022.
//

import SwiftUI
import CoreData

/// List of clothes view showing multiple filter types by ``Clothe`` properties.
struct ClothesListView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var context
    @StateObject var viewModel = ClothesListViewModel()
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\Clothe.dateOfPurchase, order: .reverse)])
    private var clothes: FetchedResults<Clothe>
    
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
    
    var body: some View {
        NavigationView {
            Group {
                List {
                    ClothePropertyPicker(value: $viewModel.selectedProperty)
                        .listRowSeparator(.hidden)
                        .onChange(of: viewModel.selectedProperty) { newValue in
                            clothes.sortDescriptors = newValue.sortDescriptor
                        }
                    
                    if !clothes.isEmpty {
                        ForEach(clothes) { clothe in
                            NavigationLink {
                                ClotheDetails(clothe: clothe)
                            } label: {
                                ClotheListRow(clothe: clothe)
                            }
                        }
                        .onDelete(perform: removeItem)
                    } else {
                        Text("ClothesListView_No results".localized)
                            .bold()
                    }
                }
                .searchable(text: query)
                .listStyle(.plain)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationButton(type: .back) {
                        dismiss()
                    }
                }
            }
            
        }
    }
    
    private func removeItem(at offset: IndexSet) {
        for index in offset {
            let clothe = clothes[index]
            context.delete(clothe)
        }
        do {
            try context.save()
        } catch {
            fatalError()
        }
    }
}

struct ClothesListView_Previews: PreviewProvider {
    static var previews: some View {
        ClothesListView()
    }
}
