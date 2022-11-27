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
    @State var activeSheet: ActiveSheet?
    //TODO: - Fix this implementation
    @AppStorage("clothe1") private var selectedClothe1: LocalClothe? = nil
    @AppStorage("clothe2") private var selectedClothe2: LocalClothe? = nil
    @AppStorage("clothe3") private var selectedClothe3: LocalClothe? = nil
    @AppStorage("clothe4") private var selectedClothe4: LocalClothe? = nil
    @AppStorage("clothe5") private var selectedClothe5: LocalClothe? = nil
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .custom) {
                Image("person1")
                
                VStack(spacing: 70) {
                    CustomOverlayedButton(selectedClothe: $selectedClothe1, customButton: NavigationButton(type: .add) {
                        activeSheet = .first
                    })
                    .padding(.leading, 70)
                    CustomOverlayedButton(selectedClothe: $selectedClothe2, customButton: NavigationButton(type: .add) {
                        activeSheet = .second
                    })
                    .padding(.leading, 30)
                    CustomOverlayedButton(selectedClothe: $selectedClothe3, customButton: NavigationButton(type: .add) {
                        activeSheet = .third
                    })
                    CustomOverlayedButton(selectedClothe: $selectedClothe4, customButton: NavigationButton(type: .add) {
                        activeSheet = .fourth
                    })
                    .padding(.leading, 30)
                    CustomOverlayedButton(selectedClothe: $selectedClothe5, customButton: NavigationButton(type: .add) {
                        activeSheet = .five
                    })
                    .padding(.leading, 70)
                }
                .alignmentGuide(HorizontalAlignment.custom)
                { d in d[.trailing] + 100 }
                    .alignmentGuide(VerticalAlignment.custom)
                { d in d[.bottom] - 230 }
            }
            .sheet(item: $activeSheet, content: { item in
                switch item {
                case .first:
                    CustomSheetView(selectedClothe: $selectedClothe1)
                case .second:
                    CustomSheetView(selectedClothe: $selectedClothe2)
                case .third:
                    CustomSheetView(selectedClothe: $selectedClothe3)
                case .fourth:
                    CustomSheetView(selectedClothe: $selectedClothe4)
                case .five:
                    CustomSheetView(selectedClothe: $selectedClothe5)
                }
            })
            .navigationTitle("Now")
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
