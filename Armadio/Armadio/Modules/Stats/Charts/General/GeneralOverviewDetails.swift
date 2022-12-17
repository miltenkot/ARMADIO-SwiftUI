//
//  GeneralOverviewDetails.swift
//  Armadio
//
//  Created by Bartłomiej on 27/11/2022.
//

import SwiftUI
import Charts

/// Details of chats.
struct GeneralOverviewDetailsChart: View {
    @FetchRequest var clothes: FetchedResults<Clothe>
    @Binding var timeRange: TimeRange
    @Binding var showAverageLine: Bool
    
    var average: Double {
        Double(clothes.count) / Double(timeRange.rawValue)
    }
    
    var body: some View {
        Chart(getDates()) {
            LineMark(
                x: .value("Mouth", $0.date),
                y: .value("Clothes", $0.count)
            )
            .foregroundStyle(showAverageLine ? .gray.opacity(0.3) : .blue)
            .interpolationMethod(.catmullRom)
            .lineStyle(StrokeStyle(lineWidth: 3))
            
            AreaMark(
                x: .value("Mouth", $0.date),
                y: .value("Clothes", $0.count)
            )
            .interpolationMethod(.catmullRom)
            .foregroundStyle(LinearGradient.gradient(.primary))
            
            if showAverageLine {
                RuleMark(
                    y: .value("Average", average)
                )
                .lineStyle(StrokeStyle(lineWidth: 3))
                .annotation(position: .top, alignment: .leading) {
                    Text("Average: \(average, specifier: "%.2f")")
                        .font(.body.bold())
                        .foregroundStyle(.blue)
                }
            }
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

extension GeneralOverviewDetailsChart {
    private func getDates() -> [MonthPlottableModel] {
        let clothesDate = clothes.map { $0.dateOfPurchase! }
        return getMouthPlottableValues(dates: clothesDate)
    }
    
    private func getMouthPlottableValues(dates: [Date]) -> [MonthPlottableModel] {
        let calendar = Calendar.current
        var array: [MonthPlottableModel] = []
        for month in 0...timeRange.rawValue {
            let count = dates.filter({ (calendar.dateComponents([.month, .year], from: Date.dateSubBy(-month))) == (calendar.dateComponents([.month, .year], from: $0)) }).count
            array.append(.init(date: Date.dateSubBy(-month), count: count))
        }
        return array
    }
}

struct GeneralOverviewDetails: View {
    @Environment(\.dismiss) var dismiss
    @FetchRequest var clothes: FetchedResults<Clothe>
    @State private var timeRange: TimeRange = .lastYear
    @State private var showAverageLine: Bool = false
    
    var body: some View {
        List {
            VStack(alignment: .leading) {
                TimeRangePicker(value: $timeRange)
                    .padding(.bottom)
                Text("Total Clothes Number")
                    .font(.callout)
                    .foregroundStyle(.secondary)
                Text("\(clothes.count) Clothes")
                    .font(.title2.bold())
                GeneralOverviewDetailsChart(clothes: _clothes,
                                          timeRange: $timeRange,
                                          showAverageLine: $showAverageLine)
                .frame(height: 240)
            }
            .listRowSeparator(.hidden)
            
            Section("Options") {
                Toggle("Show Daily Average", isOn: $showAverageLine)
            }
        }
        .listStyle(.plain)
        .navigationBarTitle("Total Clothes Number", displayMode: .inline)
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

struct GeneralOverviewDetails_Previews: PreviewProvider {
    static var previews: some View {
        GeneralOverviewDetails(clothes: .init(fetchRequest: .init(entityName: "Clothe")))
    }
}
