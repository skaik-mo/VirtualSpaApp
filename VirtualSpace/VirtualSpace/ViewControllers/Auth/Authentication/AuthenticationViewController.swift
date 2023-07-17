// _________SKAIK_MO_________
//  
//  AuthenticationViewController.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 09/07/2023.
//

import UIKit

class AuthenticationViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!

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
        setUpData()
        setUpView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

}

// MARK: - Actions
private extension AuthenticationViewController {

    @IBAction func signUpAction(_ sender: Any) {
        debugPrint(#function)
        let vc = SignUpViewController()
        vc._presentVC()
    }

    @IBAction func signInAction(_ sender: Any) {
        debugPrint(#function)
        let vc = SignInViewController()
        vc._presentVC()
    }
}

// MARK: - Configurations
private extension AuthenticationViewController {

    func setUpView() {
        self.signInButton.applyButtonStyle(.OutlinedWhite)
        self.signUpButton.applyButtonStyle(.Primary(40))
    }

    func setUpData() {
        self.titleLabel.text = Strings.VIRTUAL_SPA_TITLE
        self.subTitleLabel.text =  Strings.LOREM_IPSUM_TITLE
        self.signInButton.titleLabel?.text = Strings.SIGN_IN
        self.signUpButton.titleLabel?.text = Strings.SIGN_UP
    }
}
