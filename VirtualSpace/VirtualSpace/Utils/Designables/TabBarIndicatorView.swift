//
//  TabBarIndicatorView.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 11/07/2023.
//

import Foundation
import UIKit

class TabBarIndicatorView: UIView {

    // MARK: - Properties
    weak var tabBarController: UITabBarController? // Avoid retain memory cycles
    var animationDuration: Double = 0.2
    var width: CGFloat = 16
    var height: CGFloat = 3

    // MARK: - Required Init
    init(atTabBarController tabBarController: UITabBarController, width: CGFloat = 16, height: CGFloat = 1.5, indicatorColor: UIColor, cornerRadius: CGFloat = 0) {
        self.tabBarController = tabBarController
        self.width = width
        self.height = height

        let countVC: CGFloat = CGFloat(tabBarController.tabBar.items?.count ?? 5)
        let halfOneView = (self.tabBarController?.tabBar.frame.size.width ?? 0) / countVC / 2
        let x = halfOneView - (width / 2) // if language LTR
//        if Language.shared.isRTL {
//            x = (self.tabBarController?.tabBar.frame.size.width ?? 0) - halfOneView - (width / 2)
//        }

        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let mainWindow = windowScene?.windows.first
        let y = UIScreen.main.bounds.height - (tabBarController.tabBar.frame.height + (mainWindow?.safeAreaInsets.bottom ?? 0))

        // Setup View Frame
        super.init(frame: CGRect(x: x, y: y, width: width, height: self.height))

        self.backgroundColor = indicatorColor
        self.cornerRadius = cornerRadius
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func selectIndex(_ index: Int) {
        UIView.animate(withDuration: animationDuration) { [self] in
            guard let tabView = tabBarController?.tabBar.items?[index].value(forKey: "view") as? UIView else { return }
            self.frame = CGRect(x: (tabView.frame.maxX - ((tabView.frame.size.width / 2) + (width / 2))), y: (tabBarController?.tabBar.frame.minY ?? 0) + 0.1, width: width, height: self.frame.size.height)
        }
    }
}

//extension UIImage {
//  func createSelectionIndicator(color: UIColor, size: CGSize, lineHeight: CGFloat) -> UIImage {
//    UIGraphicsBeginImageContextWithOptions(size, false, 0)
//    color.setFill()
//    UIRectFill(CGRect(origin: CGPoint(x: 0,y : size.height - lineHeight ), size: CGSize(width: size.width, height: lineHeight)))
//    let image = UIGraphicsGetImageFromCurrentImageContext()
//    UIGraphicsEndImageContext()
//    return image!
//  }
//}
