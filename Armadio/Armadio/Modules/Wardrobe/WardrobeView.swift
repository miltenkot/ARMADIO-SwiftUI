//
//  WardrobeView.swift
//  Armadio
//
//  Created by Bartłomiej on 29/10/2022.
//

import SwiftUI
import UIKit

/// The wardrobe main view shows all ``Clothe`` grouped in categories and ``FloatingButton`` as an expanded menu with options.
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
                        Text("WardrobeView_NoContent".localized)
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
                            viewModel.activeModalView = .addNew
                        },
                                       statsAction: {
                            viewModel.activeModalView = .stats
                        }, listAction: {
                            viewModel.activeModalView = .list
                        })
                        .fullScreenCover(item: $viewModel.activeModalView) {
                            switch $0 {
                            case .addNew:
                                AddNewClotheView()
                            case .stats:
                                StatsView()
                            case .list:
                                ClothesListView()
                            }
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
