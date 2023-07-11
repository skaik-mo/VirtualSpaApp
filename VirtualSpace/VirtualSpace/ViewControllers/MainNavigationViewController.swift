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
        self.setSmallTitleFont()
        self.setNavigationBarWhenScrollViewController()
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

extension UINavigationController {

    open override func viewWillLayoutSubviews() {
        self.setBackButton()
    }

    private func setBackButton() {
        UINavigationBar.appearance().backIndicatorImage = .ic_back
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = .ic_back
        navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}
