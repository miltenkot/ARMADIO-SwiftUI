//
//  PriceOverview.swift
//  Armadio
//
//  Created by Bartłomiej on 23/11/2022.
//

import SwiftUI
import CoreData
import Charts

/// Price chart item which represent ``Clothe/price`` model.
struct PricePlottableModel: Identifiable {
    let id = UUID()
    let date: Date
    let amount: Double
}

/// Chart represents dearest and cheapest popular ``Clothe`` saved in local database.
struct PriceOverviewChart: View {
    @FetchRequest var clothes: FetchedResults<Clothe>
    
    var body: some View {
        Chart(getMouthPlottableValues()) {
            LineMark(
                x: .value("Mouth", $0.date),
                y: .value("Amount", $0.amount)
            )
            .interpolationMethod(.catmullRom)
            .lineStyle(StrokeStyle(lineWidth: 3))
            
            AreaMark(
                x: .value("Mouth", $0.date),
                y: .value("Amount", $0.amount)
            )
            .interpolationMethod(.catmullRom)
            .foregroundStyle(LinearGradient.gradient(.primary))
        }
        .chartXAxis(.hidden)
        .chartYAxis(.hidden)
    }
}

extension PriceOverviewChart {
    private func getMouthPlottableValues() -> [PricePlottableModel] {
        let calendar = Calendar.current
        var array: [PricePlottableModel] = []
        for month in 0...11 {
            let amount: Double = clothes.filter {
                calendar.dateComponents([.month], from: Date.dateSubBy(-month)) == (calendar.dateComponents([.month], from: $0.dateOfPurchase!))
            }.map {
                $0.price!.amount
            }.reduce(0, +)
            array.append(.init(date: Date.dateSubBy(-month), amount: amount))
        }
        return array
    }
}

/// Price clothes view cobined ``PriceOverviewChart`` and description.
struct PriceOverview: View {
    @FetchRequest var clothes: FetchedResults<Clothe>
    
    var totalAmount: Double {
        clothes.reduce(0) { $0 + $1.price!.amount }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("PriceOverview_TotalPrice".localized)
                .font(.callout)
                .foregroundStyle(.secondary)
            Text("\(totalAmount, specifier: "%.2f") PLN")
                .font(.title2.bold())
            PriceOverviewChart(clothes: _clothes)
                .frame(height: 100)
        }
    }
}

struct PriceOverview_Previews: PreviewProvider {
    static var previews: some View {
        PriceOverview(clothes: .init(fetchRequest: .init(entityName: "Clothe")))
    }
}
