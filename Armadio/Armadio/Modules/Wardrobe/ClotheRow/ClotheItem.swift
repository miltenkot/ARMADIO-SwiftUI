//
//  ClotheItem.swift
//  Armadio
//
//  Created by Bartłomiej on 31/10/2022.
//

import SwiftUI

/// Clothe item to use in ``ClotheRow``.
struct ClotheItem: View {
    var clothe: Clothe
    
    var body: some View {
        VStack(alignment: .leading) {
            imageView
                .renderingMode(.original)
                .resizable()
                .scaledToFill()
                .frame(width: 155, height: 155)
                .cornerRadius(5)
            HStack {
                Text(clothe.brand ?? "")
                Text("\(clothe.price?.amount ?? 0, specifier: "%.2f") \(clothe.price?.currency.rawValue.uppercased() ?? "PLN")")
            }
            .foregroundColor(.primary)
            .font(.caption)
            
        }
        .padding(.leading, 15)
    }
    
    private var imageView: Image {
        if let image = clothe.image,
           let imageData = UIImage(data: image){
            return Image(uiImage: imageData)
        } else {
            return Image("open_wardrobe")
        }
    }
}

struct ClotheItem_Previews: PreviewProvider {
    
    static var previews: some View {
        ClotheItem(clothe: Clothe.mock)
    }
}
