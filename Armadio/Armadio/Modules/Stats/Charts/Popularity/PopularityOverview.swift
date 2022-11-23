//
//  PopularityOverview.swift
//  Armadio
//
//  Created by Bartłomiej on 26/11/2022.
//

import SwiftUI
import CoreData
import Charts

struct PopularityPlottableModel: Identifiable {
    let id = UUID()
    let numberOfWorn: Int32
    let brand: String
}

struct PopularityOverviewChart: View {
    @FetchRequest var clothes: FetchedResults<Clothe>
    
    var chartData: [PopularityPlottableModel] {
        clothes.map { PopularityPlottableModel(numberOfWorn: $0.stats?.numberOfWorn ?? 0, brand: $0.brand ?? "Empty") }
    }
    
    var body: some View {
        Chart(chartData) { element in
            BarMark(
                x: .value("Number of Worn", element.numberOfWorn),
                y: .value("Brand", element.brand)
            )
            .opacity(element.brand == chartData.first?.brand ? 1 : 0.5)
        }
        .chartXAxis(.hidden)
        .chartYAxis(.hidden)
    }
}

struct PopularityOverview: View {
    @FetchRequest var clothes: FetchedResults<Clothe>
    
    init(clothes: FetchedResults<Clothe>) {
        _clothes = FetchRequest(sortDescriptors: [SortDescriptor(\.stats?.numberOfWorn, order: .reverse)])
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Most popular")
                .font(.callout)
                .foregroundStyle(.secondary)
            Text(clothes.first?.brand ?? "Empty")
                .font(.title2.bold())
            PopularityOverviewChart(clothes: _clothes)
                .frame(height: 100)
        }
    }
}
