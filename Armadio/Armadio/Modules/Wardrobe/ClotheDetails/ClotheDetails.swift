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
            CircleImage(image: imageView)
                .padding()
            VStack(alignment: .leading) {
                HStack {
                    Text(clothe.category?.name ?? "No category")
                        .font(.title)
                    FavoriteButton(isSet: .constant(true))
                }
                Text(clothe.category?.subcategory?.name ?? "No subcategory")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Divider()
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
                    
                    if let dateOfPurchase = clothe.dateOfPurchase {
                        HStack {
                            Text("Date Of Purchase: ")
                            Spacer()
                            Text(dateOfPurchase.formatted(date: .abbreviated, time: .omitted))
                        }
                        Divider()
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
    }
    
    private var imageView: Image {
        if let imageData = clothe.image {
            return Image(uiImage: UIImage(data: imageData)!)
        } else {
            return Image("clothe1")
        }
    }
    
}

struct ClotheDetails_Previews: PreviewProvider {
    static var previews: some View {
        ClotheDetails(clothe: Clothe.mock)
    }
}
