//
//  StatsView.swift
//  Armadio
//
//  Created by Bartłomiej on 23/11/2022.
//

import SwiftUI
import Charts

struct StatsView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = StatsViewModel()
    @FetchRequest(sortDescriptors: []) var clothes: FetchedResults<Clothe>
    
    private enum Destinations {
        case empty
        case general
        case price
        case popularity
    }
    
    @State private var selection: Destinations?
    
    var body: some View {
        NavigationSplitView {
            List(selection: $selection) {
                Section {
                    NavigationLink(value: Destinations.general) {
                        GeneralOverview(clothes: _clothes)
                    }
                }
                Section {
                    NavigationLink(value: Destinations.price) {
                        PriceOverview(clothes: _clothes)
                    }
                }
                Section {
                    NavigationLink(value: Destinations.popularity) {
                        PopularityOverview(clothes: clothes)
                    }
                }
            }
            .navigationTitle("Statistics")
            .listStyle(.insetGrouped)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationButton(type: .back) {
                        dismiss()
                    }
                }
            }
        } detail: {
            NavigationStack {
                switch selection ?? .empty {
                case .empty: Text("Select data to view.")
                case .general: GeneralOverviewDetails(clothes: _clothes)
                case .price: PriceOverviewDetails(clothes: _clothes)
                case .popularity: PopularityOverviewDetails(clothes: _clothes)
                }
            }
        }
    }
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView()
    }
}
