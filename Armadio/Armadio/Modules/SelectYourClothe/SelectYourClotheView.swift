//
//  SelectYourClotheView.swift
//  Armadio
//
//  Created by Bartłomiej on 15/11/2022.
//

import SwiftUI
import CoreData

/// List ``FilteredListView`` of clothes grouped by categories.
struct SelectYourClotheView: View {
    @Environment(\.managedObjectContext) var context
    @FetchRequest(sortDescriptors: []) var clothes: FetchedResults<Clothe>
    @State private var text: String = ""
    @Binding var selectedClothe: LocalClothe?
    
    var categories: [String: [Clothe]] {
        Dictionary(
            grouping: clothes,
            by: { $0.category?.name ?? "Category Name" }
        )
    }
    
    var body: some View {
        NavigationView {
            Group {
                if !clothes.isEmpty {
                    FilteredListView(selectedClothe: $selectedClothe)
                } else {
                    Text("SelectYourClotheView_NoContent".localized)
                        .textStyle(TitleStyle())
                }
            }
        }
    }
}

struct SelectYourClotheView_Previews: PreviewProvider {
    static var coreDataStack = CoreDataStack.preview
    static var previews: some View {
        SelectYourClotheView(selectedClothe: .constant(nil))
            .environment(\.managedObjectContext, coreDataStack.container.viewContext)
    }
}
