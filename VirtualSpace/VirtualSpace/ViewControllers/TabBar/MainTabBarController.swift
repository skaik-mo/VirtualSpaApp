//
//  MainTabBarController.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 11/07/2023.
//

import Foundation
import UIKit

class MainTabBarController: UITabBarController {

    private var auth: GlobalConstants.UserType = UserController().fetchUser()?.type ?? .User
    private var indicatorView: TabBarIndicatorView?
    override var title: String? {
        didSet {
            self.navigationItem.title = title
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
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
        let homeUserNavigation = MainNavigationController(rootViewController: homeUser)
        homeUserNavigation.tabBarItem.image = .ic_home
        homeUserNavigation.tabBarItem.selectedImage = .ic_homeSelected

        let therapistsPlaces = TherapistsPlacesViewController()
        let therapistsPlacesNavigation = MainNavigationController(rootViewController: therapistsPlaces)
        therapistsPlacesNavigation.tabBarItem.image = .ic_location
        therapistsPlacesNavigation.tabBarItem.selectedImage = .ic_locationSelected

        let posts = PostsViewController()
        let postsNavigation = MainNavigationController(rootViewController: posts)
        postsNavigation.tabBarItem.image = .ic_frinds
        postsNavigation.tabBarItem.selectedImage = .ic_frindsSelected

        let favorite = FavoriteViewController()
        let favoriteNavigation = MainNavigationController(rootViewController: favorite)
        favoriteNavigation.tabBarItem.image = .ic_heart
        favoriteNavigation.tabBarItem.selectedImage = .ic_heartSelected

        let profile = ProfileViewController()
        let profileNavigation = MainNavigationController(rootViewController: profile)
        profileNavigation.tabBarItem.image = .ic_profile
        profileNavigation.tabBarItem.selectedImage = .ic_profileSelected

        self.setViewControllers([homeUserNavigation, therapistsPlacesNavigation, postsNavigation, favoriteNavigation, profileNavigation], animated: true)
    }

    func setUpBusinessViewControllers() {
        let homeBusiness = HomeBusinessViewController()
        let homeBusinessNavigation = MainNavigationController(rootViewController: homeBusiness)
        homeBusinessNavigation.tabBarItem.image = .ic_home
        homeBusinessNavigation.tabBarItem.selectedImage = .ic_homeSelected

        let orders = OrdersViewController()
        let ordersNavigation = MainNavigationController(rootViewController: orders)
        ordersNavigation.tabBarItem.image = .ic_frinds
        ordersNavigation.tabBarItem.selectedImage = .ic_frindsSelected

        let notification = NotificationViewController()
        let notificationNavigation = MainNavigationController(rootViewController: notification)
        notificationNavigation.tabBarItem.image = .ic_notification
        notificationNavigation.tabBarItem.selectedImage = .ic_notificationSelected

        let profile = ProfileViewController()
        let profileNavigation = MainNavigationController(rootViewController: profile)
        profileNavigation.tabBarItem.image = .ic_profile
        profileNavigation.tabBarItem.selectedImage = .ic_profileSelected

        self.setViewControllers([homeBusinessNavigation, ordersNavigation, notificationNavigation, profileNavigation], animated: true)
    }

}

extension MainTabBarController: UITabBarControllerDelegate {

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        indicatorView?.indicatorAnimate(self.selectedIndex)
    }

}
