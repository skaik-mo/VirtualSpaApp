//
//  Helper.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 13/07/2023.
//

import Foundation
import UIKit

class Helper {

    static func call(_ phone: String) {
        guard let url = URL(string: "tel://\(phone)"), UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url)
    }
}
