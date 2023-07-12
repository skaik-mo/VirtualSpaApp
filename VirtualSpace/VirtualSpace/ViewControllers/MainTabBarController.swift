//
//  MainTabBarController.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 11/07/2023.
//

import Foundation
import UIKit

class MainTabBarController: UITabBarController {

    var auth: GlobalConstants.UserType = .User
    var indicatorView: TabBarIndicatorView?
    override var title: String? {
        didSet {
            self.navigationItem.title = title
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self._isHideNavigation = false
    }

}

private extension MainTabBarController {

    func setUpView() {
        self.delegate = self
        self.addLineInTabBar()
        switch self.auth {
        case .User:
            setUpUserViewControllers()
        case .Business:
            setUpBusinessViewControllers()
        }
        let width = self.tabBar.frame.width / CGFloat(self.tabBar.items?.count ?? 0)
        self.indicatorView = TabBarIndicatorView(atTabBarController: self, width: width, indicatorColor: .color_8C4EFF)
        if let indicatorView {
            self.view.addSubview(indicatorView)
        }
        self.tabBar.backgroundColor = .color_FFFFFF
        self.tabBar.barTintColor = .color_FFFFFF
        self.tabBar.shadowImage = UIImage()
        self.tabBar.backgroundImage = UIImage()
    }

    func setUpUserViewControllers() {
        self.navigationController?.navigationBar.backgroundColor = .red
        let vc1 = PrivacyPolicyViewController()
        vc1.tabBarItem.image = .ic_home
        vc1.tabBarItem.selectedImage = .ic_homeSelected

        let vc2 = PrivacyPolicyViewController()
        vc2.tabBarItem.image = .ic_location
        vc2.tabBarItem.selectedImage = .ic_locationSelected

        let vc3 = PrivacyPolicyViewController()
        vc3.tabBarItem.image = .ic_frinds
        vc3.tabBarItem.selectedImage = .ic_frindsSelected

        let favorite = FavoriteViewController()
        favorite.tabBarItem.image = .ic_heart
        favorite.tabBarItem.selectedImage = .ic_heartSelected

        let profile = ProfileViewController()
        profile.tabBarItem.image = .ic_profile
        profile.tabBarItem.selectedImage = .ic_profileSelected

        self.setViewControllers([vc1, vc2, vc3, favorite, profile], animated: true)
    }

    func setUpBusinessViewControllers() {
        let vc1 = PrivacyPolicyViewController()
        vc1.tabBarItem.image = .ic_home
        vc1.tabBarItem.selectedImage = .ic_homeSelected

        let vc3 = PrivacyPolicyViewController()
        vc3.tabBarItem.image = .ic_frinds
        vc3.tabBarItem.selectedImage = .ic_frindsSelected

        let vc4 = PrivacyPolicyViewController()
        vc4.tabBarItem.image = .ic_notification
        vc4.tabBarItem.selectedImage = .ic_notificationSelected

        let profile = ProfileViewController()
        profile.tabBarItem.image = .ic_profile
        profile.tabBarItem.selectedImage = .ic_profileSelected

        self.setViewControllers([vc1, vc3, vc4, profile], animated: true)
    }

    func addLineInTabBar() {
        let lineView = UIView(frame: CGRect(x: 0, y: 0, width: tabBar.frame.size.width, height: 1))
        lineView.backgroundColor = .color_000000.withAlphaComponent(0.12)
        tabBar.addSubview(lineView)
    }

    func setUpNavigation(selectedVC: UIViewController?) {
        guard let selectedVC else { return }
        if let selectedVC = selectedVC as? ProfileViewController {
            self.setUpNavigationItem(selectedVC.getUpNavigationItem())
        } else if let selectedVC = selectedVC as? FavoriteViewController {
            self.setUpNavigationItem(selectedVC.getUpNavigationItem())
        } else {
            self.setUpNavigationItem(UINavigationItem())
        }
    }

}

extension MainTabBarController: UITabBarControllerDelegate {

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        indicatorView?.selectIndex(self.selectedIndex)
        self.setUpNavigation(selectedVC: tabBarController.selectedViewController)
    }

}

extension UITabBarController {

    func setUpNavigationItem(_ navigationItem: UINavigationItem) {
        self.title = navigationItem.title
        self.navigationItem.leftBarButtonItems = navigationItem.leftBarButtonItems
        self.navigationItem.rightBarButtonItems = navigationItem.rightBarButtonItems
    }

}
