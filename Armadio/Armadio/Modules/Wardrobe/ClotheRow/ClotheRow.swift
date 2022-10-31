//
//  ClotheRow.swift
//  Armadio
//
//  Created by Bartłomiej on 31/10/2022.
//

import SwiftUI

struct ClotheRow: View {
    var categoryName: String
    var items: [Clothe]
    
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

struct ClotheRow_Previews: PreviewProvider {
    static var clothes = Clothe.clothesMock
    static var previews: some View {
        ClotheRow(categoryName: clothes[0].category.rawValue,
                   items: Array(clothes.prefix(4)))
    }
}
