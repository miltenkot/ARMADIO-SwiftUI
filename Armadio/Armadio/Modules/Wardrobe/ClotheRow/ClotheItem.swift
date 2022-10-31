//
//  ClotheItem.swift
//  Armadio
//
//  Created by Bartłomiej on 31/10/2022.
//

import SwiftUI

struct ClotheItem: View {
    var clothe: Clothe
    
    var body: some View {
        VStack(alignment: .leading) {
            clothe.image
                .renderingMode(.original)
                .resizable()
                .frame(width: 155, height: 155)
                .cornerRadius(5)
            HStack {
                Text(clothe.brand)
                Text("\(clothe.price.amount, specifier: "%.2f") \(clothe.price.currency.rawValue.uppercased())")
            }
            .foregroundColor(.primary)
            .font(.caption)
            
        }
        .padding(.leading, 15)
    }
}

struct ClotheItem_Previews: PreviewProvider {
    static var clothes = Clothe.clothesMock
    static var previews: some View {
        ClotheItem(clothe: clothes[0])
    }
}
