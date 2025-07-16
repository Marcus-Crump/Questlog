//
//  DateEqualities.swift
//  Questlog
//
//  Created by M on 7/15/25.
//

import Foundation

public func dateIsBefore(day: Int, month: Int, year: Int) -> Bool {
    let calendar = Calendar.current
    if let passedDate = calendar.date(
        from: DateComponents(year: year, month: month, day: day)) {
        let currentDate = calendar.startOfDay(for: Date())
        return passedDate < currentDate
    }
    return false
}

public func dateIsAfter(day: Int, month: Int, year: Int) -> Bool {
    let calendar = Calendar.current
    if let passedDate = calendar.date(
        from: DateComponents(year: year, month: month, day: day)) {
        let currentDate = calendar.startOfDay(for: Date())
        return passedDate > currentDate
    }
    return false
}

public func dateIsEqual(day: Int, month: Int, year: Int) -> Bool {
    let calendar = Calendar.current
    if let passedDate = calendar.date(
        from: DateComponents(year: year, month: month, day: day)) {
        let currentDate = calendar.startOfDay(for: Date())
        return passedDate == currentDate
    }
    return false
}
