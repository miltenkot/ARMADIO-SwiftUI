//
//  PopularityOverviewDetails.swift
//  Armadio
//
//  Created by Bartłomiej on 27/11/2022.
//

import SwiftUI
import Charts

struct PopularityOverviewDetailsChart: View {
    @FetchRequest var clothes: FetchedResults<Clothe>
    @Binding var timeRange: TimeRange
    
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
        .chartXAxis {
            AxisMarks(values: .stride(by: .month)) { _ in
                AxisGridLine()
                AxisTick()
                AxisValueLabel(format: .dateTime.month(.narrow), centered: true)
            }
        }
    }
}

struct PopularityOverviewDetails: View {
    @Environment(\.dismiss) var dismiss
    @FetchRequest var clothes: FetchedResults<Clothe>
    @State private var timeRange: TimeRange = .lastYear

    var body: some View {
        List {
            VStack(alignment: .leading) {
                TimeRangePicker(value: $timeRange)
                    .padding(.bottom)
                Text("PopularityOverviewDetails_MostPopular".localized)
                    .font(.callout)
                    .foregroundStyle(.secondary)
                Text(clothes.first?.brand ?? "Empty")
                    .font(.title2.bold())
                PopularityOverviewDetailsChart(clothes: _clothes,
                                               timeRange: $timeRange)
                .frame(height: 240)
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .navigationBarTitle("PopularityOverviewDetails_MostPopular".localized, displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                NavigationButton(type: .back) {
                    dismiss()
                }
            }
        }
    }
}

struct PopularityOverviewDetails_Previews: PreviewProvider {
    static var previews: some View {
        PopularityOverviewDetails(clothes: .init(fetchRequest: .init(entityName: "Clothe")))
    }
}
