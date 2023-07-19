// _________SKAIK_MO_________
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
    private var isEnableSignIn = true {
        didSet {
            self.signInButton.isEnabled = isEnableSignIn
        }
    }

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
        guard let allPresentedViews = self.getAllPresentedViews, allPresentedViews.firstIndex(of: self) == 0 else {
            self._dismissVC()
            return }
        let vc = SignUpViewController()
        self.present(vc, animated: true)
    }

    @IBAction func signInAction(_ sender: Any) {
        debugPrint(#function)
        self.signIn()
    }

    @IBAction func forgotPasswordAction(_ sender: Any) {
        debugPrint(#function)
        let vc = ForgotPasswordViewController()
        self.present(vc, animated: true) // This code for second present
    }

}

// MARK: - Configurations
private extension SignInViewController {

    func setUpView() {
        self.view.cornerRadius = 25
        self.emailTextField.setUpView(.Email)
        self.passwordTextField.setUpView()
        self.signInButton.applyButtonStyle(.Primary(40))
        self.forgotPasswordButton._underline()
    }

    func setUpData() {
        self.signUpButton.titleLabel?.text = Strings.SIGN_UP
        self.signInLabel.text = Strings.SIGN_IN
        self.descriptionLabel.text = Strings.SIGN_IN_PLACEHOLER
        self.emailTextField.title = Strings.EMAIL_TITLE
        self.passwordTextField.title = Strings.PASSWORD_TITLE
        self.passwordTextField.placeholder = Strings.PASSWORD_TITLE
        self.signInButton.titleLabel?.text = Strings.SIGN_IN
        self.forgotPasswordButton.titleLabel?.text = Strings.FORGOT_TITLE
    }

}

private extension SignInViewController {

    func validation() -> Bool {
        guard self.emailTextField.isInvalid else { return false }
        guard self.passwordTextField.isInvalid else { return false }
        return true
    }

    func signIn() {
        self.isEnableSignIn = false
        guard validation() else {
            self.isEnableSignIn = true
            return
        }
        _ = UserController().signIn(email: self.emailTextField.text, password: self.passwordTextField.text).handlerDidFinishRequest {
            debugPrint("handlerDidFinishRequest")
            self.isEnableSignIn = true
        }.handlerofflineLoad {
            debugPrint("handlerofflineLoad")
            self.isEnableSignIn = true
        }
    }

}
