// _________SKAIK_MO_________
//
//  OrdersViewController.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 13/07/2023.
//

import UIKit
import XLPagerTabStrip

class OrdersViewController: ButtonBarPagerTabStripViewController {

    // MARK: Outlets
    @IBOutlet weak var superStack: UIStackView!

    // MARK: Properties

    // MARK: Init
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Life Cycle
    override func viewDidLoad() {
        self.setUpButtonBarPagerTab()
        super.viewDidLoad()
        setUpView()
    }

    // MARK: - PagerTabStripDataSource
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let pending = OrdersPendingViewController()
        let accepted = OrdersAcceptedViewController()
        return [pending, accepted]
    }

}

// MARK: - Configurations
private extension OrdersViewController {

    func setUpView() {
        self.superStack.layoutMargins.top = (self.navigationController?.navigationBar.frame.height ?? 0) + (self._getStatusBarHeightTop ?? 0)
        let line = UIView()
        line.backgroundColor = .color_A3A3A3.withAlphaComponent(0.3)
        let height: CGFloat = 1
        line.frame = CGRect(x: 0, y: buttonBarView.frame.height - height - 0.5, width: buttonBarView.frame.width, height: height)
        buttonBarView.addSubview(line)
    }

    func setUpButtonBarPagerTab() {
        settings.style.buttonBarItemFont = .poppinsMedium13
        settings.style.buttonBarBackgroundColor = .clear
        settings.style.buttonBarItemBackgroundColor = .clear
        settings.style.selectedBarBackgroundColor = .color_000000
        settings.style.selectedBarHeight = 2.0
        settings.style.buttonBarMinimumLineSpacing = 45
        settings.style.buttonBarItemTitleColor = .color_9B9B9B
        settings.style.selectedBarVerticalAlignment = .bottom
        settings.style.buttonBarLeftContentInset = 100
        settings.style.buttonBarRightContentInset = 100

        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, _: CGFloat, changeCurrentIndex: Bool, _: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = .color_9B9B9B
            newCell?.label.textColor = .color_000000
        }
    }

}

// MARK: - set Up Navigation
extension OrdersViewController {
    func getUpNavigationItem() -> UINavigationItem {
        return UINavigationItem(title: Strings.ORDERS_TITLE)
    }
}
