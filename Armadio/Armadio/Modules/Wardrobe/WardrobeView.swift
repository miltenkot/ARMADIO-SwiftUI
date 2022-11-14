//
//  WardrobeView.swift
//  Armadio
//
//  Created by Bartłomiej on 29/10/2022.
//

import SwiftUI
import UIKit

struct WardrobeView: View {
    @StateObject var viewModel = WardrobeViewModel()
    @Environment(\.managedObjectContext) var context
    @FetchRequest(sortDescriptors: []) var clothes: FetchedResults<Clothe>
    
    var categories: [String: [Clothe]] {
        Dictionary(
            grouping: clothes,
            by: { $0.category?.name ?? "Category Name" }
        )
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Group {
                    if !clothes.isEmpty {
                        List {
                            if let imageData = clothes[0].image {
                                Image(uiImage: UIImage(data: imageData)!)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(height: 200)
                                    .clipped()
                                    .listRowInsets(EdgeInsets())
                            }
                            
                            ForEach(categories.keys.sorted(), id: \.self) { key in
                                ClotheRow(categoryName: key, items: clothes)
                                    .padding(.vertical)
                            }
                            .listRowInsets(EdgeInsets())
                        }
                    } else {
                        Text("No content")
                            .textStyle(TitleStyle())
                    }
                }
                .navigationTitle("WardrobeView_Wardrobe".localized)
                .blur(radius: viewModel.menuButtonExpanded ? 5 : 0)
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        FloatingButton(showMenuItems: $viewModel.menuButtonExpanded,
                                       addNewAction: {
                            viewModel.isAddNewOpen.toggle()
                        },
                                       statsAction: {
                            viewModel.isStatsOpen.toggle()
                        },
                                       outfitsAction: {
                            viewModel.isOutfitsOpen.toggle()
                        })
                        .fullScreenCover(isPresented: $viewModel.isAddNewOpen) {
                            AddNewClotheView()
                        }
                        .fullScreenCover(isPresented: $viewModel.isStatsOpen) {
                            AddNewClotheView()
                        }
                        .fullScreenCover(isPresented: $viewModel.isOutfitsOpen) {
                            AddNewClotheView()
                        }
                    }
                    .padding()
                }
            }
        }
    }
}

struct WardrobeView_Previews: PreviewProvider {
    static var coreDataStack = CoreDataStack.preview
    
    static var previews: some View {
        Group {
            WardrobeView()
                .environment(\.managedObjectContext, coreDataStack.container.viewContext)
            WardrobeView()
        }
        
    }
}
