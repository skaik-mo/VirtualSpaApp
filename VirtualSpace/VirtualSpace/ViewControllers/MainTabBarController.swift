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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
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
    }

    func setUpUserViewControllers() {
        let vc1 = PrivacyPolicyViewController()
        vc1.tabBarItem.image = .ic_home
        vc1.tabBarItem.selectedImage = .ic_homeSelected

        let vc2 = PrivacyPolicyViewController()
        vc2.tabBarItem.image = .ic_location
        vc2.tabBarItem.selectedImage = .ic_locationSelected

        let vc3 = PrivacyPolicyViewController()
        vc3.tabBarItem.image = .ic_frinds
        vc3.tabBarItem.selectedImage = .ic_frindsSelected

        let vc4 = PrivacyPolicyViewController()
        vc4.tabBarItem.image = .ic_heart
        vc4.tabBarItem.selectedImage = .ic_heartSelected

        let vc5 = PrivacyPolicyViewController()
        vc5.tabBarItem.image = .ic_profile
        vc5.tabBarItem.selectedImage = .ic_profileSelected

        self.setViewControllers([vc1, vc2, vc3, vc4, vc5], animated: true)
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

        let vc5 = PrivacyPolicyViewController()
        vc5.tabBarItem.image = .ic_profile
        vc5.tabBarItem.selectedImage = .ic_profileSelected

        self.setViewControllers([vc1, vc3, vc4, vc5], animated: true)
    }

    func addLineInTabBar() {
        let lineView = UIView(frame: CGRect(x: 0, y: 0, width: tabBar.frame.size.width, height: 1))
        lineView.backgroundColor = .color_000000.withAlphaComponent(0.12)
        tabBar.addSubview(lineView)
    }

}

extension MainTabBarController: UITabBarControllerDelegate {

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        debugPrint(#function)
        debugPrint(self.selectedIndex)
//        tabBar.selectionIndicatorImage = item.image?.createSelectionIndicator(color: UIColor.red, size: CGSize(width: tabBar.frame.width / CGFloat(tabBar.items!.count), height: 18), lineHeight: 2.0)

    }

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        debugPrint(#function)
        debugPrint(self.selectedIndex)
        indicatorView?.selectIndex(self.selectedIndex)
    }

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        debugPrint(#function)
        debugPrint(self.selectedIndex)
        return true
    }

}
//
//extension UIImage {
//    func createSelectionIndicator(color: UIColor, size: CGSize, lineHeight: CGFloat) -> UIImage? {
//        UIGraphicsBeginImageContextWithOptions(size, false, 0)
//        color.setFill()
//        UIRectFill(CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: size.width, height: lineHeight)))
//        let image = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        return image
//    }
//}
