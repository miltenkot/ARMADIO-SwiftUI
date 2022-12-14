//
//  PriceOverviewDetails.swift
//  Armadio
//
//  Created by Bartłomiej on 26/11/2022.
//

import SwiftUI
import Charts

struct PriceOverviewDetailsChart: View {
    @FetchRequest var clothes: FetchedResults<Clothe>
    @Binding var timeRange: TimeRange
    @Binding var showAverageLine: Bool
    
    var average: Double {
        clothes.reduce(0) { $0 + $1.price!.amount } / Double(timeRange.rawValue)
    }
    
    var body: some View {
        Chart(getMouthPlottableValues()) {
            LineMark(
                x: .value("Mouth", $0.date),
                y: .value("Amount", $0.amount)
            )
            .foregroundStyle(showAverageLine ? .gray.opacity(0.3) : .blue)
            .interpolationMethod(.catmullRom)
            .lineStyle(StrokeStyle(lineWidth: 3))
            
            AreaMark(
                x: .value("Mouth", $0.date),
                y: .value("Amount", $0.amount)
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

extension PriceOverviewDetailsChart {
    private func getMouthPlottableValues() -> [PricePlottableModel] {
        let calendar = Calendar.current
        var array: [PricePlottableModel] = []
        for month in 0...timeRange.rawValue {
            let amount: Double = clothes.filter {
                calendar.dateComponents([.month, .year], from: Date.dateSubBy(-month)) == (calendar.dateComponents([.month, .year], from: $0.dateOfPurchase!))
            }.map {
                $0.price!.amount
            }.reduce(0, +)
            array.append(.init(date: Date.dateSubBy(-month), amount: amount))
        }
        return array
    }
}

struct PriceOverviewDetails: View {
    @Environment(\.dismiss) var dismiss
    @FetchRequest var clothes: FetchedResults<Clothe>
    @State private var timeRange: TimeRange = .lastYear
    @State private var showAverageLine: Bool = false
    
    var totalAmount: Double {
        clothes.reduce(0) { $0 + $1.price!.amount }
    }
    
    var body: some View {
        List {
            VStack(alignment: .leading) {
                TimeRangePicker(value: $timeRange)
                    .padding(.bottom)
                Text("Total price")
                    .font(.callout)
                    .foregroundStyle(.secondary)
                Text("\(totalAmount, specifier: "%.2f") PLN")
                    .font(.title2.bold())
                PriceOverviewDetailsChart(clothes: _clothes,
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
        .navigationBarTitle("Total price", displayMode: .inline)
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

struct PriceOverviewDetails_Previews: PreviewProvider {
    static var previews: some View {
        PriceOverviewDetails(clothes: .init(fetchRequest: .init(entityName: "Clothe")))
    }
}
