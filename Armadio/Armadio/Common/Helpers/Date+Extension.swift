//
//  Date+Extension.swift
//  Armadio
//
//  Created by Bartłomiej on 27/11/2022.
//

import Foundation

/// Provide simpler date representation e.q. `last mount == Date.dateSubBy(-1)`
extension Date {
    static func dateSubBy(_ months: Int) -> Self {
        Calendar.current.date(byAdding: .month, value: months, to: .now)!
    }
}
