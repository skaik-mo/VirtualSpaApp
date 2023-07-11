//
//  PasswordValidator.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 11/07/2023.
//

import Foundation

struct PasswordValidator: Validator {
    var field: String = Strings.PASSWORD_TITLE
    var validationRules: [ValidationRule]

    init() {
        self.validationRules = [
            CharacterCountValidationRule(field: field, minCount: 6, maxCount: nil)
        ]
    }

}
