// _________SKAIK_MO_________
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
        navigationBarAppearance.shadowColor = .color_A3A3A3
        navigationBarAppearance.titleTextAttributes = getSmallTitleFont()
        navigationBarAppearance.backgroundColor = getBackgroundColor()
        navigationBarAppearance.setBackIndicatorImage(.ic_back, transitionMaskImage: .ic_back)
        navigationBar.scrollEdgeAppearance = navigationBarAppearance
        navigationBarAppearance.backgroundColor = getBackgroundColorWhenScrollViewController()
        navigationBar.standardAppearance = navigationBarAppearance
    }

    private func getSmallTitleFont() -> [NSAttributedString.Key: Any] {
        [NSAttributedString.Key.foregroundColor: UIColor.color_000000, NSAttributedString.Key.font: UIFont.poppinsMedium17]
    }

    private func getBackgroundColor() -> UIColor {
            .color_FFFFFF
    }

    private func getBackgroundColorWhenScrollViewController() -> UIColor {
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
        super.viewWillLayoutSubviews()
        self.setBackButton()
    }

    private func setBackButton() {
        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationBar.topItem?.backBarButtonItem = backButton
    }
}
