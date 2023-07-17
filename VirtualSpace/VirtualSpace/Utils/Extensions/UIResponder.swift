// _________SKAIK_MO_________
//
//  UIResponder.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 09/07/2023.
//

import Foundation
import UIKit

extension UIResponder {
    static var _id: String {
        return String(describing: self)
    }

    var _topVC: UIViewController? {
        return SceneDelegate.shared?.rootNavigationController?._topMostViewController
    }

}
