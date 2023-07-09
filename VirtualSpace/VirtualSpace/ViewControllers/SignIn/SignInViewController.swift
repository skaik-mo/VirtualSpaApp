//_________SKAIK_MO_________
//  
//  SignInViewController.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 09/07/2023.
//

import UIKit

class SignInViewController: UIViewController {

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
private extension SignInViewController {

}

// MARK: - Configurations
private extension SignInViewController {

    func setUpView() {

    }

    func setUpData() {

    }

    func fetchData() {

    }

}

