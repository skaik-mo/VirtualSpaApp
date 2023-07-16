//
//  Date.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 16/07/2023.
//

import Foundation

extension Date {

    var _stringTime: String {
        return self._string(dataFormat: GlobalConstants.timeFormat)
    }

    func _string(dataFormat: String, timeZone: String = TimeZone.current.identifier) -> String {
        let formatter = DateFormatter()
        formatter.calendar = Calendar.init(identifier: .gregorian)
        formatter.dateFormat = dataFormat
        formatter.timeZone = TimeZone.init(identifier: timeZone)
        return formatter.string(from: self)
    }

    /// Returns a Date with the specified amount of components added to the one it is called with
    func _add(years: Int = 0, months: Int = 0, days: Int = 0, hours: Int = 0, minutes: Int = 0, seconds: Int = 0) -> Date? {
        let components = DateComponents(year: years, month: months, day: days, hour: hours, minute: minutes, second: seconds)
        return Calendar.current.date(byAdding: components, to: self)
    }

}
