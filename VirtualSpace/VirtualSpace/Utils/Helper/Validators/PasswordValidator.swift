//
//  PasswordValidator.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 11/07/2023.
//

import Foundation

struct PasswordValidator: Validator {
    var field: String
    var validationRules: [ValidationRule]

    init(field: String) {
        self.field = field
        self.validationRules = [
            CharacterCountValidationRule(field: field, minCount: 6, maxCount: nil)
        ]
    }

}
