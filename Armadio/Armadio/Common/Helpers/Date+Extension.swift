//
//  Date+Extension.swift
//  Armadio
//
//  Created by Bartłomiej on 27/11/2022.
//

import Foundation

extension Date {
    static func dateSubBy(_ months: Int) -> Self {
        Calendar.current.date(byAdding: .month, value: months, to: .now)!
    }
}
