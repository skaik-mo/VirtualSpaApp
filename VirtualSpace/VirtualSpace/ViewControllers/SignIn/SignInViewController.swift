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
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var signInLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var emailTextField: MainTextView!
    @IBOutlet weak var passwordTextField: PasswordTextFieldView!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var forgotPasswordButton: UIButton!

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
private extension SignInViewController {
    @IBAction func signUpAction(_ sender: Any) {
        debugPrint(#function)
    }

    @IBAction func signInAction(_ sender: Any) {
        debugPrint(#function)
    }

    @IBAction func forgotPasswordAction(_ sender: Any) {
        debugPrint(#function)
    }

}

// MARK: - Configurations
private extension SignInViewController {

    func setUpView() {
        self.view.cornerRadius = 25
        self.emailTextField.setUpView(.Email)
        self.passwordTextField.setUpView()
        self.signInButton.applyButtonStyle(.Primary)
        self.forgotPasswordButton._underline()
    }

    func setUpData() {
        self.signUpButton.titleLabel?.text = Strings.SIGN_UP
        self.signInLabel.text = Strings.SIGN_IN
        self.descriptionLabel.text = Strings.SIGN_IN_PLACEHOLER
        self.emailTextField.title = Strings.EMAIL_TITLE
        self.emailTextField.placeholder = Strings.EMAIL_TITLE
        self.passwordTextField.title = Strings.PASSWORD_TITLE
        self.passwordTextField.placeholder = Strings.PASSWORD_TITLE
        self.signInButton.titleLabel?.text = Strings.SIGN_IN
        self.forgotPasswordButton.titleLabel?.text = Strings.FORGOT_TITLE
    }

}

