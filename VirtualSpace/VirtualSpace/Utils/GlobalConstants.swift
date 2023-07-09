//_________SKAIK_MO_________
//
//  GlobalConstants.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 09/07/2023.
//

import Foundation
import UIKit

class GlobalConstants {

    // MARK: - typealias
    //typealias typealiasName = ((_ message: String?) -> Void)?

    // MARK: - enums

    // MARK: - Images
    //let ic_imageName = "ic_imageName"

    // MARK: - Format

}

extension UIFont {

    static var poppinsRegular14: UIFont {
        UIFont(name: "Poppins-Medium", size: 14) ?? UIFont.systemFont(ofSize: 14, weight: .medium)
//        UIFont(name: "Poppins-Regular", size: 34) ?? UIFont.systemFont(ofSize: 1, weight: .medium)
    }

    static var poppinsRegular17: UIFont {
        UIFont(name: "Poppins-Medium", size: 17) ?? UIFont.systemFont(ofSize: 17, weight: .medium)
    }

}

extension UIColor {
    static var color_8C4EFF: UIColor {
        return UIColor(hexString: "#8C4EFF")
    }

    static var color_18B58C: UIColor {
        return UIColor(hexString: "#18B58C")
    }

    static var color_FAF9FD: UIColor {
        return UIColor(hexString: "#FAF9FD")
    }

    static var color_FF0101: UIColor {
        return UIColor(hexString: "#FF0101")
    }

    static var color_FFFFFF: UIColor {
        return UIColor(hexString: "#FFFFFF")
    }

    static var color_000000: UIColor {
        return UIColor(hexString: "#000000")
    }

//    static var color_: UIColor {
//        return UIColor(hexString: "#")
//    }

}
