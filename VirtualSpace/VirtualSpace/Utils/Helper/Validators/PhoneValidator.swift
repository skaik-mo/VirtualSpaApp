//
//  PhoneValidator.swift
//  EyeApp
//
//  Created by Mohammed Skaik on 08/07/2023.
//

import Foundation

struct PhoneValidator: Validator {
    var field: String = Strings.PHONE_NUM_TITLE
    var validationRules: [ValidationRule] = []

    init() {
        self.validationRules = [
//            RegexValidationRule(field: field, regex: #"^(?:\+|00|01)\d+$"#),
            CharacterCountValidationRule(field: field, minCount: 5, maxCount: 16)
        ]
    }
}
