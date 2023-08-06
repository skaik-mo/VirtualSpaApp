//_________SKAIK_MO_________
//
//  Country.swift
//  
//
//  Created by Mohammed Skaik on 06/08/2023.
//

import Foundation

class Country {
    var name: String
    var code: String
    var dialCode: String
    var format: String
    var flag: String
    var flagURL: String

    init(name: String, code: String, dialCode: String, format: String, flag: String, flagURL: String) {
        self.name = name
        self.code = code
        self.dialCode = dialCode
        self.format = format
        self.flag = flag
        self.flagURL = flagURL
    }

    static func > (next: Country, previous: Country) -> Bool {
        return previous.name > next.name
    }

}
