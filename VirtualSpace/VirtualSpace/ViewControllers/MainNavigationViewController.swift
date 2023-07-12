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
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.shadowColor = "#A3A3A3"._color
        navigationBarAppearance.titleTextAttributes = self.setSmallTitleFont()
        navigationBarAppearance.backgroundColor = setNavigationBarWhenScrollViewController()
        navigationBar.scrollEdgeAppearance = navigationBarAppearance
    }

    private func setSmallTitleFont() -> [NSAttributedString.Key: Any] {
        [NSAttributedString.Key.foregroundColor: UIColor.color_000000, NSAttributedString.Key.font: UIFont.poppinsMedium17]
    }

    private func setNavigationBarWhenScrollViewController() -> UIColor {
            .color_FFFFFF
    }

}

// MARK: - Root transfers
extension MainNavigationController {

    private func setRoot() {
        let vc = LaunchViewController()
        vc._rootPush()
    }

    static func showFirstView() {
        if let auth = AuthController().fetchAuth() {
            let vc = MainTabBarController()
            vc.auth = auth
            vc._rootPush()
            vc._isHideNavigation = false
        } else {
            let vc = AuthenticationViewController()
            vc._rootPush()
            vc._isHideNavigation = true
        }
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
