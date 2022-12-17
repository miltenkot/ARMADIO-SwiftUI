//
//  GeneralOverview.swift
//  Armadio
//
//  Created by Bartłomiej on 23/11/2022.
//

import SwiftUI
import CoreData
import Charts

/// Model of month used in ``GeneralOverviewChart``.
struct MonthPlottableModel: Identifiable {
    let id = UUID()
    let date: Date
    let count: Int
}

/// Chart represents general statistics of``Clothe`` saved in local database.
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
    private func getDates() -> [MonthPlottableModel] {
        let clothesDate = clothes.map { $0.dateOfPurchase! }
        return getMouthPlottableValues(dates: clothesDate)
    }
    
    private func getMouthPlottableValues(dates: [Date]) -> [MonthPlottableModel] {
        let calendar = Calendar.current
        var array: [MonthPlottableModel] = []
        for month in 0...11 {
            let count = dates.filter({ (calendar.dateComponents([.month], from: Date.dateSubBy(-month))) == (calendar.dateComponents([.month], from: $0)) }).count
            array.append(.init(date: Date.dateSubBy(-month), count: count))
        }
        return array
    }
}

/// General view cobined ``GeneralOverviewChart`` and description.
struct GeneralOverview: View {
    @FetchRequest var clothes: FetchedResults<Clothe>
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("GeneralOverview_TotalClothesNumber".localized)
                .font(.callout)
                .foregroundStyle(.secondary)
            Text("\(clothes.count) \("GeneralOverview_Clothes".localized)")
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
