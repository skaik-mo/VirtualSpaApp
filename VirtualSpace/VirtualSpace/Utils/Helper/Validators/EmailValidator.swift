//
//  EmailValidator.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 11/07/2023.
//

import Foundation

struct EmailValidator: Validator {
    var field: String = Strings.EMAIL_TITLE
    var validationRules: [ValidationRule]

    init() {
        self.validationRules = [
            RegexValidationRule(field: field, regex: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}")
        ]
    }

}
