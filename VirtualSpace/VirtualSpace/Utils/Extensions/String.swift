// _________SKAIK_MO_________
//
//  String.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 09/07/2023.
//

import Foundation
import UIKit

extension String {

    var _hexColor: UIColor {
        return UIColor.init(named: self) ?? UIColor.init(hexString: self)
    }

    var _color: UIColor {
        return UIColor.init(named: self) ?? UIColor.init(hexString: self)
    }

    var _colorcg: CGColor {
        return self._hexColor.cgColor
    }

    var _toImage: UIImage? {
        return UIImage.init(named: self)
    }

    var _localizedKey: String {
        return NSLocalizedString(self, comment: "")
    }
    var _removeWhiteSpace: String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    var _isValidValue: Bool {
        return !self._removeWhiteSpace.isEmpty
    }

    // if emailTest == true
    // This is a valid email such as "Example@gmail.com".
    var _isEmailValid: Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"

        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailFormat)
        return emailTest.evaluate(with: self)
    }

    // If the value is invalid, the output default value will be 0
    var _toInteger: Int? {
        return (self as NSString).integerValue
    }

    // If the value is invalid, the output default value will be 0.0
    var _toDouble: Double {
        return (self as NSString).doubleValue
    }

    // If the value is invalid, the output default value will be 0.0
    var _toFloat: Float {
        return (self as NSString).floatValue
    }

    // If the value is invalid, the output default value will be false
    var _toBool: Bool {
        return (self as NSString).boolValue
    }

    init(withInt int: Int, leadingZeros: Int = 2) {
        self.init(format: "%0\(leadingZeros)d", int)
    }

    func _dateWithFormate(dataFormat: String, timeZone: String = TimeZone.current.identifier) -> Date? {
        let formatter = DateFormatter()
        formatter.calendar = Calendar.init(identifier: .gregorian)
        formatter.dateFormat = dataFormat
        formatter.timeZone = TimeZone.init(identifier: timeZone)
        return formatter.date(from: self)
    }
}
