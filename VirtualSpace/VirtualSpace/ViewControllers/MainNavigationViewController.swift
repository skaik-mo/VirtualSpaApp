// _________SKAIK_MO_________
//
//  MainNavigationViewController.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 09/07/2023.
//

import UIKit

class MainNavigationController: UINavigationController {

    private let navigationBarAppearance = UINavigationBarAppearance()
    var shadowColor: UIColor = .color_A3A3A3 {
        didSet {
            self.setUpNavigation()
        }
    }
    var backgroundColor: UIColor = .color_FFFFFF {
        didSet {
            self.setUpNavigation()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpNavigation()
    }
}

// MARK: - Configuration
extension MainNavigationController {

    func setUpNavigation() {
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.shadowColor = self.shadowColor
        navigationBarAppearance.titleTextAttributes = getSmallTitleFont()
        navigationBarAppearance.backgroundColor = self.backgroundColor
        navigationBarAppearance.setBackIndicatorImage(.ic_back, transitionMaskImage: .ic_back)
        navigationBar.scrollEdgeAppearance = navigationBarAppearance
        navigationBarAppearance.backgroundColor = getBackgroundColorWhenScrollViewController()
        navigationBar.standardAppearance = navigationBarAppearance
    }

    private func getSmallTitleFont() -> [NSAttributedString.Key: Any] {
        [NSAttributedString.Key.foregroundColor: UIColor.color_000000, NSAttributedString.Key.font: UIFont.poppinsMedium17]
    }

    private func getBackgroundColorWhenScrollViewController() -> UIColor {
            .color_FFFFFF
    }

}

// MARK: - Root transfers
extension MainNavigationController {

    func setRoot() {
        let vc = AuthenticationViewController()
        self._rootPush(vc)
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

    override func _rootPush(_ vc: UIViewController) {
        self.setViewControllers([vc], animated: true)
    }
}
