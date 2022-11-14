//
//  ClotheNowRow.swift
//  Armadio
//
//  Created by Bartłomiej on 17/11/2022.
//

import SwiftUI

struct ClotheNowRow: View {
    @Binding var isDisplayed: Bool
    @Binding var selectedClothe: Clothe?
    
    var body: some View {
        Button(action: {
            isDisplayed.toggle()
        }, label: {
            if let selectedClothe,
               let data = selectedClothe.image,
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
                            Text(selectedClothe.category?.name ?? "Empty")
                                .font(.custom("AvenirNext-Regular", size: 15))
                                .foregroundColor(.gray)
                            Text(selectedClothe.category?.subcategory?.name ?? "Empty")
                                .font(.custom("AvenirNext-Demibold", size: 15))
                        }
                    }
                    .padding(.top, 20)
                }
            } else {
                HStack {
                    Spacer()
                    Image(systemName: "plus")
                        .resizable()
                        .foregroundColor(.themeColor(.primaryText))
                        .frame(width: 50, height: 50)
                    Spacer()
                }
            }
        })
        .frame(height: 150)
    }
}

struct ClotheNowRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ClotheNowRow(isDisplayed: .constant(false), selectedClothe: .constant(nil))
            ClotheNowRow(isDisplayed: .constant(false), selectedClothe: .constant(Clothe.mock))
        }
    }
}
