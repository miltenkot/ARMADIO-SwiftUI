//
//  ClotheRow.swift
//  Armadio
//
//  Created by Bartłomiej on 31/10/2022.
//

import SwiftUI

/// Single item represents ``Clothe`` to use in ``FilteredListView``.
struct ClotheRow: View {
    let categoryName: String
    let detailsAvailable: Bool
    let action: ((Clothe) -> Void)?
    @FetchRequest var items: FetchedResults<Clothe>
    
    init(categoryName: String, items: FetchedResults<Clothe>, detailsAvailable: Bool = true, action: ((Clothe) -> Void)? = nil) {
        self.categoryName = categoryName
        _items = FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "category.name == %@", categoryName))
        self.detailsAvailable = detailsAvailable
        self.action = action
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
                        if detailsAvailable {
                            NavigationLink {
                                ClotheDetails(clothe: clothe)
                            } label: {
                                ClotheItem(clothe: clothe)
                            }
                        } else {
                            Button {
                                action?(clothe)
                            } label: {
                                ClotheItem(clothe: clothe)
                            }

                        }
                    }
                }
            }
        }
    }
}

// MARK: - Create preview
