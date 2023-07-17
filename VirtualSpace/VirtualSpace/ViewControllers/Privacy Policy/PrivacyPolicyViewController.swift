// _________SKAIK_MO_________
//  
//  PrivacyPolicyViewController.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 11/07/2023.
//

import UIKit

class PrivacyPolicyViewController: UIViewController {

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
        super.viewDidLoad()
        setUpView()
        setUpData()
        fetchData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

}

// MARK: - Actions
private extension PrivacyPolicyViewController {

}

// MARK: - Configurations
private extension PrivacyPolicyViewController {

    func setUpView() {
        self.view.cornerRadius = 25
    }

    func setUpData() {

    }

    func fetchData() {

    }

}
