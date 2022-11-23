//
//  TimeRangePicker.swift
//  Armadio
//
//  Created by Bartłomiej on 27/11/2022.
//

import SwiftUI

enum TimeRange: Int {
    case lastYear = 11
    case last2Years = 23
    case allTime = 30
}

struct TimeRangePicker: View {
    @Binding var value: TimeRange

    var body: some View {
        Picker("Time Range", selection: $value.animation(.easeInOut)) {
            Text("1 Year").tag(TimeRange.lastYear)
            Text("2 Years").tag(TimeRange.last2Years)
            Text("All").tag(TimeRange.allTime)
        }
        .pickerStyle(.segmented)
    }
}

struct TimeRangePicker_Previews: PreviewProvider {
    static var previews: some View {
        TimeRangePicker(value: .constant(.lastYear))
    }
}
