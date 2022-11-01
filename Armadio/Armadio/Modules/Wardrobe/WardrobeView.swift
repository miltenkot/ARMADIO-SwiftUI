//
//  WardrobeView.swift
//  Armadio
//
//  Created by Bartłomiej on 29/10/2022.
//

import SwiftUI

struct WardrobeView: View {
    @StateObject var viewModel = WardrobeViewModel()
    @State private var isAddNewOpen = false
    @State private var isStatsOpen = false
    @State private var isOutfitsOpen = false
    
    var body: some View {
        NavigationView {
            ZStack {
                content
                    .navigationTitle("WardrobeView_Wardrobe".localized)
                    .blur(radius: viewModel.menuButtonExpanded ? 5 : 0)
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        FloatingButton(showMenuItems: $viewModel.menuButtonExpanded,
                                       addNewAction: {
                            isAddNewOpen.toggle()
                        },
                                       statsAction: {
                            isStatsOpen.toggle()
                        },
                                       outfitsAction: {
                            isOutfitsOpen.toggle()
                        })
                        .fullScreenCover(isPresented: $isAddNewOpen) {
                            AddNewClotheView()
                        }
                        .fullScreenCover(isPresented: $isStatsOpen) {
                            AddNewClotheView()
                        }
                        .fullScreenCover(isPresented: $isOutfitsOpen) {
                            AddNewClotheView()
                        }
                    }
                    .padding()
                }
                
            }
            
        }
    }
    
    @ViewBuilder
    var content: some View {
        if !viewModel.clothes.isEmpty {
            List {
                viewModel.clothes[0].image
                    .resizable()
                    .scaledToFill()
                    .frame(height: 200)
                    .clipped()
                    .listRowInsets(EdgeInsets())
                ForEach(viewModel.categories.keys.sorted(), id: \.self) { key in
                    ClotheRow(categoryName: key, items: viewModel.categories[key] ?? [])
                        .padding(.vertical)
                }
                .listRowInsets(EdgeInsets())
            }
        } else {
            Text("No content")
        }
    }
    
}

struct WardrobeView_Previews: PreviewProvider {
    static var previews: some View {
        WardrobeView()
    }
}
