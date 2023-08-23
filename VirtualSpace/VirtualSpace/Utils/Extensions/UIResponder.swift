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

    var _rootViewController: UIViewController? {
        return SceneDelegate.shared?.window?.rootViewController
    }

    var _navigationController: UINavigationController? {
        if let navigationController = _rootViewController as? UINavigationController {
            return navigationController
        } else if let tabBarController = _rootViewController as? UITabBarController {
            if let selectedNavigationController = tabBarController.selectedViewController as? UINavigationController {
                return selectedNavigationController
            }
        }
        return nil
    }

    var _topVC: UIViewController? {
        return _rootViewController?._topMostViewController
    }

}
