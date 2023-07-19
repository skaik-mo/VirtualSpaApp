//
//  MainTabBarController.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 11/07/2023.
//

import Foundation
import UIKit

class MainTabBarController: UITabBarController {

    var auth: GlobalConstants.UserType = UserController().fetchUser()?.type ?? .User
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
        setUpNavigation(selectedVC: self.selectedViewController)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        setUpShadowColor()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        indicatorView?.indicatorWidth = self.tabBar.frame.width / CGFloat(self.tabBar.items?.count ?? 0)
        indicatorView?.indicatorAnimate(0)
    }

}

private extension MainTabBarController {

    func setUpView() {
        self.delegate = self
        self.indicatorView = TabBarIndicatorView(frame: self.tabBar.frame)
        self.setValue(indicatorView, forKey: "tabBar")
        switch self.auth {
        case .User:
            setUpUserViewControllers()
        case .Business:
            setUpBusinessViewControllers()
        }
    }

    func setUpUserViewControllers() {
        self.navigationController?.navigationBar.backgroundColor = .red
        let homeUser = HomeUserViewController()
        homeUser.tabBarItem.image = .ic_home
        homeUser.tabBarItem.selectedImage = .ic_homeSelected

        let vc2 = TherapistsPlacesViewController()
        vc2.tabBarItem.image = .ic_location
        vc2.tabBarItem.selectedImage = .ic_locationSelected

        let posts = PostsViewController()
        posts.tabBarItem.image = .ic_frinds
        posts.tabBarItem.selectedImage = .ic_frindsSelected

        let favorite = FavoriteViewController()
        favorite.tabBarItem.image = .ic_heart
        favorite.tabBarItem.selectedImage = .ic_heartSelected

        let profile = ProfileViewController()
        profile.tabBarItem.image = .ic_profile
        profile.tabBarItem.selectedImage = .ic_profileSelected

        self.setViewControllers([homeUser, vc2, posts, favorite, profile], animated: true)
    }

    func setUpBusinessViewControllers() {
        let homeBusiness = HomeBusinessViewController()
        homeBusiness.tabBarItem.image = .ic_home
        homeBusiness.tabBarItem.selectedImage = .ic_homeSelected

        let orders = OrdersViewController()
        orders.tabBarItem.image = .ic_frinds
        orders.tabBarItem.selectedImage = .ic_frindsSelected

        let notification = NotificationViewController()
        notification.tabBarItem.image = .ic_notification
        notification.tabBarItem.selectedImage = .ic_notificationSelected

        let profile = ProfileViewController()
        profile.tabBarItem.image = .ic_profile
        profile.tabBarItem.selectedImage = .ic_profileSelected

        self.setViewControllers([homeBusiness, orders, notification, profile], animated: true)
    }

    func setUpNavigation(selectedVC: UIViewController?) {
        self.setUpShadowColor()
        guard let selectedVC else { return }
        if let selectedVC = selectedVC as? HomeUserViewController {
            self.setUpShadowColor(.clear)
            self.setUpNavigationItem(selectedVC.getUpNavigationItem())
        } else if let selectedVC = selectedVC as? FavoriteViewController {
            self.setUpNavigationItem(selectedVC.getUpNavigationItem())
        } else if let selectedVC = selectedVC as? PostsViewController {
            self.setUpNavigationItem(selectedVC.getUpNavigationItem())
        } else if let selectedVC = selectedVC as? TherapistsPlacesViewController {
            self.setUpNavigationItem(selectedVC.getUpNavigationItem())
        } else if let selectedVC = selectedVC as? HomeBusinessViewController {
            self.setUpNavigationItem(selectedVC.getUpNavigationItem())
        } else if let selectedVC = selectedVC as? NotificationViewController {
            self.setUpNavigationItem(selectedVC.getUpNavigationItem())
        } else if let selectedVC = selectedVC as? OrdersViewController {
            self.setUpNavigationItem(selectedVC.getUpNavigationItem())
        } else if let selectedVC = selectedVC as? ProfileViewController {
            self.setUpNavigationItem(selectedVC.getUpNavigationItem())
        } else {
            self.setUpNavigationItem(UINavigationItem())
        }
    }

    func setUpShadowColor(_ shadowColor: UIColor = .color_A3A3A3) {
        SceneDelegate.shared?.rootNavigationController?.shadowColor = shadowColor
    }

}

extension MainTabBarController: UITabBarControllerDelegate {

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        indicatorView?.indicatorAnimate(self.selectedIndex)
        self.setUpNavigation(selectedVC: tabBarController.selectedViewController)
    }

}

extension UITabBarController {

    func setUpNavigationItem(_ navigationItem: UINavigationItem) {
        self.title = navigationItem.title
        self.navigationItem.titleView = navigationItem.titleView
        self.navigationItem.leftBarButtonItems = navigationItem.leftBarButtonItems
        self.navigationItem.rightBarButtonItems = navigationItem.rightBarButtonItems
    }

}
