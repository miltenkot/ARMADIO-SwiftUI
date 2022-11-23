//
//  GeneralOverview.swift
//  Armadio
//
//  Created by Bartłomiej on 23/11/2022.
//

import SwiftUI
import CoreData
import Charts

struct MouthPlottableModel: Identifiable {
    let id = UUID()
    let date: Date
    let count: Int
}

struct GeneralOverviewChart: View {
    @FetchRequest var clothes: FetchedResults<Clothe>

    var body: some View {
        Chart(getDates()) {
            LineMark(
                x: .value("Mouth", $0.date),
                y: .value("Clothes", $0.count)
            )
            .interpolationMethod(.catmullRom)
            .lineStyle(StrokeStyle(lineWidth: 3))
            
            AreaMark(
                x: .value("Mouth", $0.date),
                y: .value("Clothes", $0.count)
            )
            .interpolationMethod(.catmullRom)
            .foregroundStyle(LinearGradient.gradient(.primary))
        }
        .chartXAxis(.hidden)
        .chartYAxis(.hidden)
    }
}

extension GeneralOverviewChart {
    private func getDates() -> [MouthPlottableModel] {
        let clothesDate = clothes.map { $0.dateOfPurchase! }
        return getMouthPlottableValues(dates: clothesDate)
    }
    
    private func getMouthPlottableValues(dates: [Date]) -> [MouthPlottableModel] {
        let calendar = Calendar.current
        var array: [MouthPlottableModel] = []
        for month in 0...11 {
            let count = dates.filter({ (calendar.dateComponents([.month], from: Date.dateSubBy(-month))) == (calendar.dateComponents([.month], from: $0)) }).count
            array.append(.init(date: Date.dateSubBy(-month), count: count))
        }
        return array
    }
}

struct GeneralOverview: View {
    @FetchRequest var clothes: FetchedResults<Clothe>
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Total Clothes Number")
                .font(.callout)
                .foregroundStyle(.secondary)
            Text("\(clothes.count) Clothes")
                .font(.title2.bold())
            GeneralOverviewChart(clothes: _clothes)
                .frame(height: 100)
        }
    }
}

struct GeneralOverview_Preview: PreviewProvider {
    static var previews: some View {
        GeneralOverview(clothes: .init(fetchRequest: .init(entityName: "Clothe")))
    }
}
