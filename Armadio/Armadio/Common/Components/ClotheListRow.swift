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
                VStack(alignment: .leading) {
                    HStack {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: 120, maxHeight: 120)
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
                    .padding(.top, 20)
                }
            }
        }
        .frame(height: 150)
    }
}

struct ClotheNowRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ClotheListRow(clothe: Clothe.mock)
        }
    }
}
