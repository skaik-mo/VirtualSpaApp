//_________SKAIK_MO_________
//  
//  TherapistViewController.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 16/07/2023.
//

import UIKit
import XLPagerTabStrip

class TherapistViewController: ButtonBarPagerTabStripViewController {

    // MARK: Outlets

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
        setUpData()
        fetchData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    // MARK: - PagerTabStripDataSource
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let posts = PostsViewController()
        let info = TherapistInfoViewController()
        return [posts, info]
    }

}

// MARK: - Actions
private extension TherapistViewController {

}

// MARK: - Configurations
private extension TherapistViewController {

    func setUpView() {
        let line = UIView()
        line.backgroundColor = .color_A3A3A3.withAlphaComponent(0.3)
        let height: CGFloat = 1
        line.frame = CGRect(x: 0, y: buttonBarView.frame.height - height - 0.5
            , width: buttonBarView.frame.width, height: height)
        buttonBarView.addSubview(line)
    }

    func setUpData() {
        self.title = Strings.MESSAGE_THERAPISTS_TITLE
    }

    func fetchData() {

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

        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = .color_9B9B9B
            newCell?.label.textColor = .color_000000
        }
    }

}
