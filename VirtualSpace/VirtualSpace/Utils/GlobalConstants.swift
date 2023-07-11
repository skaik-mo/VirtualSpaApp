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
    enum UserType: Int {
        case User = 0
        case Business = 1
    }

    // MARK: - Format

}

// MARK: - Images
extension UIImage {
    static var ic_back: UIImage? {
        "ic_back"._toImage
    }

    static var ic_frinds: UIImage? {
        "ic_frinds"._toImage
    }

    static var ic_frindsSelected: UIImage? {
        "ic_frindsSelected"._toImage
    }

    static var ic_heart: UIImage? {
        "ic_heart"._toImage
    }

    static var ic_heartSelected: UIImage? {
        "ic_heartSelected"._toImage
    }

    static var ic_home: UIImage? {
        "ic_home"._toImage
    }

    static var ic_homeSelected: UIImage? {
        "ic_homeSelected"._toImage
    }

    static var ic_location: UIImage? {
        "ic_location"._toImage
    }

    static var ic_locationSelected: UIImage? {
        "ic_locationSelected"._toImage
    }

    static var ic_profile: UIImage? {
        "ic_profile"._toImage
    }

    static var ic_profileSelected: UIImage? {
        "ic_profileSelected"._toImage
    }

    static var ic_notification: UIImage? {
        "ic_notification"._toImage
    }

    static var ic_notificationSelected: UIImage? {
        "ic_notificationSelected"._toImage
    }


}


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


}

// MARK: - Colors
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

    static var color_7A7A7A: UIColor {
        return UIColor(hexString: "#7A7A7A")
    }

    static var color_424343: UIColor {
        return UIColor(hexString: "#424343")
    }

//    static var color_: UIColor {
//        return UIColor(hexString: "#")
//    }

}
