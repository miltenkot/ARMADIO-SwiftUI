//
//  ClotheRow.swift
//  Armadio
//
//  Created by Bartłomiej on 31/10/2022.
//

import SwiftUI

struct ClotheRow: View {
    var categoryName: String
    @FetchRequest var items: FetchedResults<Clothe>
    
    init(categoryName: String, items: FetchedResults<Clothe>) {
        self.categoryName = categoryName
        _items = FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "category.name == %@", categoryName))
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(categoryName.uppercased())
                .font(.headline)
                .padding(.leading, 15)
                .padding(.top, 5)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 0) {
                    ForEach(items) { clothe in
                        NavigationLink {
                            ClotheDetails(clothe: clothe)
                        } label: {
                            ClotheItem(clothe: clothe)
                        }
                    }
                }
            }
        }
    }
}

// MARK: - Create preview
