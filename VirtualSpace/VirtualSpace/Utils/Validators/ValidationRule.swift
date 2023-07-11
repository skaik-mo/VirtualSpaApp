//
//  ValidationRule.swift
//  EyeApp
//
//  Created by Mohammed Skaik on 08/07/2023.
//

import Foundation

protocol ValidationRule {
    typealias ValueType = String
    var field: String { get set }

    func validate(_ value: ValueType) throws

    /// Validates whether a given value is considered valid according to the validation rules.
    func hasValidValue(_ value: ValueType) -> Bool
}

extension ValidationRule {

    func hasValidValue(_ value: ValueType) -> Bool {
        do {
            try NilValidationRule(field: self.field).validate(value)
            try validate(value)
            return true
        } catch let error {
            SceneDelegate.shared?.rootNavigationController?._showErrorAlertOK(message: error.localizedDescription)
            return false
        }
    }
}

// MARK: Available Validation Rules
struct NilValidationRule: ValidationRule {
    var field: String

    func validate(_ value: ValueType) throws {
        guard value._isValidValue else { throw ValidationError(errorDescription: Strings.INVALID_VALUE_MESSAGE.replacingOccurrences(of: "{field}", with: field)) }
    }

}

struct RegexValidationRule: ValidationRule {
    var field: String
    let regex: String

    func validate(_ value: ValueType) throws {
        guard value.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil else {
            throw ValidationError(errorDescription: Strings.INVALID_RANGE_MESSAGE.replacingOccurrences(of: "{field}", with: field))
        }
    }
}

struct CharacterCountValidationRule: ValidationRule {
    var field: String
    let minCount: Int?
    let maxCount: Int?
    var replacements: [String: Any?] = [:]

    init(field: String, minCount: Int?, maxCount: Int?) {
        self.field = field
        self.minCount = minCount
        self.maxCount = maxCount
        self.replacements = [
            "{field}": field,
            "{minimum}": minCount,
            "{maximum}": maxCount
        ]
    }

    func validate(_ value: ValueType) throws {
        guard !((value.count >= minCount ?? Int.min) && (value.count <= maxCount ?? Int.max)) else { return }
        var errorMsg = ""
        if let minimum = minCount, let maximum = maxCount {
            if minimum == maximum {
                errorMsg = replacements.reduce(Strings.INVALID_LENGTH_MINIMUM_EXACTLY_MESSAGE, { partialResult, replace in
                    partialResult.replacingOccurrences(of: replace.key, with: "\(replace.value ?? "")")
                })
            } else {
                errorMsg = replacements.reduce(Strings.INVALID_LENGTH_BETWEEN_MINIMUM_MAXIMUM_MESSAGE, { partialResult, replace in
                    partialResult.replacingOccurrences(of: replace.key, with: "\(replace.value ?? "")")
                })
            }
        } else if minCount != nil {
            errorMsg = replacements.reduce(Strings.INVALID_LENGTH_MINIMUM_MESSAGE, { partialResult, replace in
                partialResult.replacingOccurrences(of: replace.key, with: "\(replace.value ?? "")")
            })
        } else if maxCount != nil {
            errorMsg = replacements.reduce(Strings.INVALID_LENGTH_MAXIMUM_MESSAGE, { partialResult, replace in
                partialResult.replacingOccurrences(of: replace.key, with: "\(replace.value ?? "")")
            })
        }
        throw ValidationError(errorDescription: errorMsg)
    }
}

// struct NumbericValidationRule: ValidationRule {
//    var field: String
//
//    func validate(_ value: ValueType) throws {
//        if value.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) != nil {
//            throw ValidationError(errorDescription: "\(field) should contain numbers only")
//        }
//    }
// }
//
// struct DecimalValidationRule: ValidationRule {
//    var field: String
//
//    func validate(_ value: ValueType) throws {
//        if Double(value) == nil {
//            throw ValidationError(errorDescription: "\(field) should contain Decimals only")
//        }
//    }
// }
//
// struct FirstCharValidationRule: ValidationRule {
//    var field: String
//    let chars: [Character]
//
//    func validate(_ value: ValueType) throws {
//        guard let firstChar = value.first else { return }
//        if !chars.contains(firstChar) {
//            let stringArray = chars.map({ return String($0) })
//            let prefixes = stringArray.joined(separator: ", ")
//            throw ValidationError(errorDescription: "incorrect Prefix \(prefixes)")
//        }
//    }
// }
//
// struct WithinLimitsValidationRule: ValidationRule {
//    var field: String
//    let min: Double
//    let max: Double
//
//    func validate(_ value: ValueType) throws {
//        guard let doubleValue = Double(value) else { return }
//
//        if !(doubleValue >= min && doubleValue <= max) {
//            guard let doubleValue = Double(value) else { return }
//
//            if doubleValue > max {
//                throw ValidationError(errorDescription: "value exceeds maximum allowed value")
//            } else if doubleValue < min {
//                throw ValidationError(errorDescription: "value fails to reach the minimum allowed value")
//            }
//        }
//    }
// }
