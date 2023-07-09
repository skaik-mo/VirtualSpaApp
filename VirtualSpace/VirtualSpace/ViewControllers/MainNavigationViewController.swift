//_________SKAIK_MO_________
//
//  MainNavigationViewController.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 09/07/2023.
//

import UIKit

class MainNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpNavigation()
    }
}

// MARK: - Configuration
extension MainNavigationController {

    private func setUpNavigation() {
        self.setRoot()
        self.removeBackTitleButtonColor()
        self.ChangeBackTitleButtonColor()
        self.setSmallTitleFont()
        self.setNavigationBarWhenScrollViewController()
    }

    private func removeBackTitleButtonColor() {
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: .normal)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: UIControl.State.highlighted)
    }

    private func ChangeBackTitleButtonColor() {
        UIBarButtonItem.appearance().tintColor = .color_000000
    }

    private func setSmallTitleFont() {
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.color_000000, NSAttributedString.Key.font: UIFont.poppinsRegular17]
    }

//    private func removeShadow() {
//        UINavigationBar.appearance().shadowImage = UIImage.init()
//    }

    private func setNavigationBarWhenScrollViewController() {
        UINavigationBar.appearance().barTintColor = .white
    }

}

// MARK: - Root transfers
extension MainNavigationController {

    private func setRoot() {
        let vc = LaunchViewController()
        vc._rootPush()
    }

    static func showFirstView() {
        let vc = AuthenticationViewController()
        vc._rootPush()
    }

}
