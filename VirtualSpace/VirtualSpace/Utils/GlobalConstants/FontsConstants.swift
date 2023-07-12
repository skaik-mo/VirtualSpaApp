//
//  FontsConstants.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 12/07/2023.
//

import Foundation
import UIKit

// MARK: - Fonts
extension UIFont {

    static var poppinsMedium13: UIFont {
        UIFont(name: "Poppins-Medium", size: 13) ?? UIFont.systemFont(ofSize: 13, weight: .medium)
    }

    static var poppinsMedium17: UIFont {
        UIFont(name: "Poppins-Medium", size: 17) ?? UIFont.systemFont(ofSize: 17, weight: .medium)
    }

    static var poppinsRegular14: UIFont {
        UIFont(name: "Poppins-Regular", size: 14) ?? UIFont.systemFont(ofSize: 14, weight: .regular)
    }

    static var poppinsSemiBold14: UIFont {
        UIFont(name: "Poppins-SemiBold", size: 14) ?? UIFont.systemFont(ofSize: 14, weight: .semibold)
    }

}
