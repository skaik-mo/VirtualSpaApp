//_________SKAIK_MO_________
//
//  UIViewController.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 09/07/2023.
//

import Foundation
import UIKit

// MARK: - Transfers Shortcuts
extension UIViewController {

    var _topMostViewController: UIViewController? {
        if let navigationController = self as? UINavigationController {
            return navigationController.topViewController?._topMostViewController
        } else if let tabBarController = self as? UITabBarController {
            if let selectedViewController = tabBarController.selectedViewController {
                return selectedViewController._topMostViewController
            }
            return tabBarController._topMostViewController
        } else if let presentedViewController = self.presentedViewController {
            return presentedViewController._topMostViewController
        } else {
            return self
        }
    }

    func _rootPush() {
        SceneDelegate.shared?.rootNavigationController?.setViewControllers([self], animated: true)
    }

    func _push() {
        SceneDelegate.shared?.rootNavigationController?.pushViewController(self, animated: true)
    }

    func _presentVC() {
        SceneDelegate.shared?.rootNavigationController?.present(self, animated: true, completion: nil)
    }

    func _pop() {
        SceneDelegate.shared?.rootNavigationController?.popViewController(animated: true)
    }

    func _dismissVC() {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func _popViewController(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func _popViewControllerWithoutAnimated(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }

    @IBAction func _dismissViewController(_ sender: Any) {
        self._dismissVC()
    }

    @IBAction func _dismissViewControllerWithoutAnimated(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
}

// MARK: - Alerts Shortcuts
extension UIViewController {
    func _showAlertOK(title: String = Strings.ALERT_TITLE, message: String?, okButtonAction: (() -> Void)? = nil) {
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        let okayAction = UIAlertAction.init(title: Strings.OK_TITLE, style: .default) { _ in
            okButtonAction?()
        }
        alert.addAction(okayAction)
        alert._presentVC()
    }

    func _showErrorAlertOK(title: String = Strings.WRONG_TITLE, message: String?, okButtonAction: (() -> Void)? = nil) {
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        let okayAction = UIAlertAction.init(title: Strings.OK_TITLE, style: .destructive) { _ in
            okButtonAction?()
        }

        alert.addAction(okayAction)
        alert._presentVC()
    }

    func _showAlert(title: String = Strings.ALERT_TITLE, message: String?, buttonTitle1: String = Strings.OK_TITLE, buttonTitle2: String = Strings.CANCEL_TITLE, buttonAction1: @escaping (() -> Void), buttonAction2: (() -> Void)?) {
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        let okayAction = UIAlertAction.init(title: buttonTitle1, style: .default) { _ in
            debugPrint("Okay aciton is pressed")
            buttonAction1()
        }
        let cancelAction = UIAlertAction.init(title: buttonTitle2, style: .cancel) { _ in
            debugPrint("Cancel aciton is pressed")
            buttonAction2?()
        }
        alert.addAction(okayAction)
        alert.addAction(cancelAction)
        alert._presentVC()
    }

}

extension UIViewController {

    var _getStatusBarHeightBottom: CGFloat? {
        return SceneDelegate.shared?.window?.safeAreaInsets.bottom
    }

    var _getStatusBarHeightTop: CGFloat? {
        return SceneDelegate.shared?.window?.safeAreaInsets.top
    }

    var _screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }

    var _screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }

    var _isHideNavigation: Bool {
        get {
            return self.navigationController?.isNavigationBarHidden ?? false
        }
        set {
            self.navigationController?.setNavigationBarHidden(newValue, animated: true)
        }
    }

    func _emptyImgaeNavigation() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage.init(), for: .top, barMetrics: .default)
    }

    func _nilImgaeNavigation() {
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
    }

}
