//
//  ClotheDetails.swift
//  Armadio
//
//  Created by Bartłomiej on 31/10/2022.
//

import SwiftUI
import UIKit

struct ClotheDetails: View {
    @Environment(\.dismiss) var dismiss
    @State private var isReceiptModalShown = false
    var clothe: Clothe
    
    var body: some View {
        ScrollView {
            CircleImage(image: imageView)
                .padding()
            VStack(alignment: .leading) {
                Group {
                    HStack {
                        Text(clothe.category?.name ?? "No category")
                            .font(.title)
                        FavoriteButton(isSet: .constant(true))
                    }
                    Text(clothe.category?.subcategory?.name ?? "No subcategory")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Divider()
                }
                Group {
                    Group {
                        if let price = clothe.price {
                            HStack {
                                Text("Price: ")
                                Spacer()
                                Text("\(price.amount, specifier: "%.2f") \(price.currency.rawValue.uppercased())")
                            }
                            Divider()
                        }
                        
                        if let brand = clothe.brand {
                            HStack {
                                Text("Brand: ")
                                Spacer()
                                Text(brand)
                            }
                            Divider()
                        }
                        
                        
                        if let material = clothe.material {
                            HStack {
                                Text("Material: ")
                                Spacer()
                                Text(material)
                            }
                            Divider()
                        }
                    }
                    Group {
                        if let size = clothe.size {
                            HStack {
                                Text("Size: ")
                                Spacer()
                                Text(size)
                            }
                            Divider()
                        }
                        
                        if let color = clothe.color {
                            HStack {
                                Text("Color: ")
                                Spacer()
                                Text(color.description)
                                    .padding(.horizontal, 25)
                                    .padding(.vertical, 4)
                                    .foregroundColor(Color.themeColor(.primaryText))
                                    .background(color)
                                    .cornerRadius(4)
                            }
                            Divider()
                        }
                        Group {
                            if let dateOfPurchase = clothe.dateOfPurchase {
                                HStack {
                                    Text("Date Of Purchase: ")
                                    Spacer()
                                    Text(dateOfPurchase.formatted(date: .abbreviated, time: .omitted))
                                }
                                Divider()
                            }
                            
                            if let numberOfWorn = clothe.stats?.numberOfWorn {
                                HStack {
                                    Text("Number Of Wears ")
                                    Spacer()
                                    Text("\(numberOfWorn)")
                                }
                                Divider()
                            }
                            
                            if let recentlyWorn = clothe.stats?.recentlyWornDate {
                                HStack {
                                    Text("Number Of Wears ")
                                    Spacer()
                                    Text(recentlyWorn.formatted(date: .abbreviated, time: .omitted))
                                }
                                Divider()
                            }
                        }
                    }
                }
                .font(.title3)
                
                if let description = clothe.desc {
                    HStack {
                        Text("Description: ")
                            .font(.title3)
                        Spacer()
                        Text(description)
                    }
                    Divider()
                }
            }
            .padding()
        }
        .navigationTitle(clothe.category?.name?.uppercased() ?? "Empty")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    isReceiptModalShown.toggle()
                } label: {
                    Image(systemName: "doc.text.viewfinder")
                }
            }
            ToolbarItem(placement: .navigationBarLeading) {
                NavigationButton(type: .back) {
                    dismiss()
                }
            }
        }
        .sheet(isPresented: $isReceiptModalShown) {
            ReceiptDetails(imageData: clothe.receipt?.image)
        }
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

struct ClotheDetails_Previews: PreviewProvider {
    static var previews: some View {
        ClotheDetails(clothe: Clothe.mock)
    }
}
