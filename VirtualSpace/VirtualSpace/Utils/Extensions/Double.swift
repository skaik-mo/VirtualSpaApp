//
//  Double.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 30/07/2023.
//

import Foundation

extension Double {

    var _toString: String {
        return String(format: "%.2f", self)
    }

    func _toString(number: Int) -> String {
        return String(format: "%.\(number)f", self)
    }

}
