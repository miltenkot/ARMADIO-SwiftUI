//
//  NowView.swift
//  Armadio
//
//  Created by Bartłomiej on 14/11/2022.
//

import SwiftUI
import CoreData
import UIKit

enum ActiveSheet: Identifiable {
    case first, second, third, fourth, five
    
    var id: Int {
        hashValue
    }
}

struct NowView: View {
    @StateObject var viewModel = NowViewModel()
    @State private var activeSheet: ActiveSheet?
    
    @AppStorage(AppStorageKey.avatarName.rawValue)
    private var avatarName: String? = nil
    
    @AppStorage(AppStorageKey.clotheTop.rawValue)
    private var selectedClotheTop: LocalClothe? = nil
    
    @AppStorage(AppStorageKey.clotheMiddle.rawValue)
    private var selectedClotheMiddle: LocalClothe? = nil
    
    @AppStorage(AppStorageKey.clotheBottom.rawValue)
    private var selectedClotheBottom: LocalClothe? = nil
    
    @AppStorage(AppStorageKey.clotheAccessories.rawValue)
    private var selectedClotheAccessories: LocalClothe? = nil
    
    @AppStorage(AppStorageKey.clotheShoes.rawValue)
    private var selectedClotheShoes: LocalClothe? = nil
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .custom) {
                if avatarName == nil {
                    VStack {
                        Text("NowView_Select".localized)
                            .textStyle(NormalStyle())
                        ScrollView(.horizontal) {
                            LazyHStack {
                                ForEach(1...5, id: \.self) { value in
                                    Button {
                                        avatarName = "person\(value)"
                                    } label: {
                                        Image("person\(value)")
                                            .frame(width: Constants.widthLarge)
                                            .padding()
                                    }
                                }
                            }
                        }
                    }
                } else {
                    Image(avatarName!)
                    
                    VStack(spacing: Constants.spacingLarge) {
                        CustomOverlayedButton(selectedClothe: $selectedClotheTop, customButton: NavigationButton(type: .add) {
                            activeSheet = .first
                        })
                        .padding(.leading, Constants.paddingLeadingLarge)
                        
                        CustomOverlayedButton(selectedClothe: $selectedClotheMiddle, customButton: NavigationButton(type: .add) {
                            activeSheet = .second
                        })
                        .padding(.leading, Constants.paddingLeadingMedium)
                        
                        CustomOverlayedButton(selectedClothe: $selectedClotheBottom, customButton: NavigationButton(type: .add) {
                            activeSheet = .third
                        })
                        
                        CustomOverlayedButton(selectedClothe: $selectedClotheAccessories, customButton: NavigationButton(type: .add) {
                            activeSheet = .fourth
                        })
                        .padding(.leading, Constants.paddingLeadingMedium)
                        
                        CustomOverlayedButton(selectedClothe: $selectedClotheShoes, customButton: NavigationButton(type: .add) {
                            activeSheet = .five
                        })
                        .padding(.leading, Constants.paddingLeadingLarge)
                    }
                    .alignmentGuide(HorizontalAlignment.custom)
                    { d in d[.trailing] + 100 }
                        .alignmentGuide(VerticalAlignment.custom)
                    { d in d[.bottom] - 230 }
                }
            }
            .sheet(item: $activeSheet, content: { item in
                switch item {
                case .first:
                    CustomSheetView(selectedClothe: $selectedClotheTop)
                case .second:
                    CustomSheetView(selectedClothe: $selectedClotheMiddle)
                case .third:
                    CustomSheetView(selectedClothe: $selectedClotheBottom)
                case .fourth:
                    CustomSheetView(selectedClothe: $selectedClotheAccessories)
                case .five:
                    CustomSheetView(selectedClothe: $selectedClotheShoes)
                }
            })
            .navigationTitle("NowView_Title".localized)
        }
    }
}

struct NowView_Previews: PreviewProvider {
    static var coreDataStack = CoreDataStack.preview
    static var previews: some View {
        NowView()
            .environment(\.managedObjectContext, coreDataStack.container.viewContext)
    }
}
