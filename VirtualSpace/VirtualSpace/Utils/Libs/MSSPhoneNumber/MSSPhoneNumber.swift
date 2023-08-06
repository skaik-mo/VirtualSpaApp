//_________SKAIK_MO_________
//
//  MSSPhoneNumber.swift
//  
//
//  Created by Mohammed Skaik on 06/08/2023.
//

import Foundation

class MSSPhoneNumber {

    public var countries: [Country] = {
        var countries: [Country] = []
        do {
            if let path = Bundle.main.path(forResource: "countryCodes", ofType: "json") {
                let url = URL(fileURLWithPath: path)
                let data = try Data(contentsOf: url)
                let array = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: String]]
                array?.forEach({ object in
                    guard let name = object["name"],
                        let code = object["code"],
                        let dialCode = object["dialCode"],
                        let format = object["format"],
                        let flag = object["flag"],
                        let flagURL = object["flagURL"] else {
                        debugPrint("Must be valid json.")
                        return
                    }
                    countries.append(Country(name: name, code: code, dialCode: dialCode, format: format, flag: flag, flagURL: flagURL))
                })
            } else {
                debugPrint("MSSPhoneNumber >>> Can't find a bundle for the countries")
            }
        } catch {
            debugPrint("MSSPhoneNumber >>> \(error.localizedDescription)")
        }
        countries = countries.sorted(by: >)
        return countries
    }()

    func getCountry(code: String) -> Country? {
        return countries.first(where: { $0.code == code })
    }

    func getCountry(dialCode: String) -> Country? {
        return countries.first(where: { $0.dialCode == dialCode })
    }

    func getCountries(_ text: String) -> [Country] {
        return countries.filter({ $0.code.contains(text) || $0.name.contains(text) })
    }

}
