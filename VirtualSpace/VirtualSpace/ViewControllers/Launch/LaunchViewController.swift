// _________SKAIK_MO_________
//
//  LaunchViewController.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 09/07/2023.
//

import UIKit

class LaunchViewController: UIViewController {

    // MARK: Outlets

    // MARK: Properties
    private var timer: Timer?

    // MARK: Init
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self._isHideNavigation = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
    }

}

// MARK: - Actions
private extension LaunchViewController {

    @objc func goToTabBar() {
        MainNavigationController.showFirstView()
    }

}

// MARK: - Configurations
private extension LaunchViewController {

    func setUpView() {
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(goToTabBar), userInfo: nil, repeats: false)
    }

}
