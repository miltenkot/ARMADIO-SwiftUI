//
//  ClotheNowRow.swift
//  Armadio
//
//  Created by Bartłomiej on 17/11/2022.
//

import SwiftUI

struct ClotheListRow: View {
    let clothe: Clothe
    
    var body: some View {
        Group {
            if let data = clothe.image,
               let uiImage = UIImage(data: data) {
                listRow(uiImage)
            } else {
                listRow(UIImage(imageLiteralResourceName: "open_wardrobe"))
            }
        }
        .frame(height: Constants.heightLarge)
    }
}

extension ClotheListRow {
    private func listRow(_ uiImage: UIImage) -> some View {
        return VStack(alignment: .leading) {
            HStack {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: Constants.widthMedium,
                           maxHeight: Constants.heightMedium)
                    .clipped()
                    .cornerRadius(10)
                VStack(alignment: .leading) {
                    Text(clothe.category?.name ?? "Empty")
                        .font(.custom("AvenirNext-Regular", size: 15))
                        .foregroundColor(.gray)
                    Text(clothe.category?.subcategory?.name ?? "Empty")
                        .font(.custom("AvenirNext-Demibold", size: 15))
                }
            }
            .padding(.top, Constants.paddingTopSmall)
        }
    }
}

struct ClotheNowRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ClotheListRow(clothe: Clothe.mock)
        }
    }
}
