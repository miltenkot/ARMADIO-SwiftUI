//
//  ClotheDetails.swift
//  Armadio
//
//  Created by Bartłomiej on 31/10/2022.
//

import SwiftUI

struct ClotheDetails: View {
    var clothe: Clothe
    
    var body: some View {
        ScrollView {
            CircleImage(image: clothe.image)
                .padding()
            VStack(alignment: .leading) {
                HStack {
                    Text(clothe.brand)
                        .font(.title)
                    FavoriteButton(isSet: .constant(true))
                }
                Text(clothe.description)
                .font(.subheadline)
                .foregroundColor(.secondary)
                Divider()
                HStack {
                    Text("Price: ")
                    Spacer()
                    Text("\(clothe.price.amount, specifier: "%.2f") \(clothe.price.currency.rawValue.uppercased())")
                }
                .font(.title3)
                Divider()
                HStack {
                    Text("Material: ")
                    Spacer()
                    Text(clothe.material)
                }
                .font(.title3)
                Divider()
                HStack {
                    Text("Date Of Purchase: ")
                    Spacer()
                    Text(clothe.dateOfPurchase.formatted(date: .abbreviated, time: .omitted))
                }
                .font(.title3)
            }
            .padding()
        }
        .navigationTitle(clothe.category.rawValue.uppercased())
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ClotheDetails_Previews: PreviewProvider {
    static var clothes = Clothe.clothesMock
    static var previews: some View {
        ClotheDetails(clothe: clothes[0])
    }
}
