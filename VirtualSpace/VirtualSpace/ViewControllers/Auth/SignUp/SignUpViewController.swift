// _________SKAIK_MO_________
//
//  SignUpViewController.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 09/07/2023.
//

import UIKit

class SignUpViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var userButton: UIButton!
    @IBOutlet weak var busniessButton: UIButton!
    @IBOutlet weak var nameTextField: MainTextView!
    @IBOutlet weak var emailTextField: MainTextView!
    @IBOutlet weak var phoneTextField: MSSPhoneNumberTextView!
    @IBOutlet weak var passwordTextField: PasswordTextFieldView!
    @IBOutlet weak var privacyButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!

    // MARK: Properties
    private var type: GlobalConstants.UserType = .User {
        didSet {
            self.setUpUserType()
        }
    }
    private var isEnableSignUp = true {
        didSet {
            self.signUpButton.isEnabled = isEnableSignUp
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
private extension SignUpViewController {
    @IBAction func signInAction(_ sender: Any) {
        guard let allPresentedViews = self.getAllPresentedViews, allPresentedViews.firstIndex(of: self) == 0 else {
            self._dismissVC()
            return }
        let vc = SignInViewController()
        vc._presentVC()
    }

    @IBAction func userAction(_ sender: Any) {
        self.type = .User
    }

    @IBAction func businessAction(_ sender: Any) {
        self.type = .Business
    }

    @IBAction func privacyAction(_ sender: Any) {
        let vc = PrivacyPolicyViewController()
        vc._presentVC()
    }

    @IBAction func signUpAction(_ sender: Any) {
        self.signUp()
    }
}

// MARK: - Configurations
private extension SignUpViewController {

    func setUpView() {
        self.view.cornerRadius = 25
        self.nameTextField.setUpView(.Normal)
        self.emailTextField.setUpView(.Email)
        self.phoneTextField.setUpView()
        self.passwordTextField.setUpView()
        self.signUpButton.applyButtonStyle(.Primary())
        setButtonAttribute()
    }

    func setUpData() {
        self.signInButton.title = Strings.SIGN_IN
        self.signUpLabel.text = Strings.SIGN_UP
        self.descriptionLabel.text = Strings.FILL_DATA_TITLE
        self.userButton.title = Strings.USER_TITLE
        self.nameTextField.title = Strings.NAME_TITLE
        self.emailTextField.title = Strings.EMAIL_TITLE
        self.phoneTextField.title = Strings.PHONE_NUM_TITLE
        self.phoneTextField.countryCode = "US"
        self.passwordTextField.title = Strings.PASSWORD_TITLE
        self.passwordTextField.placeholder = Strings.PASSWORD_TITLE
        self.busniessButton.title = Strings.BUSINESS_TITLE
        self.signUpButton.title = Strings.SIGN_UP
        self.type = .User
    }

    func setUpUserType() {
        switch self.type {
        case .User:
            self.userButton.applyButtonStyle(.OutlinedPurple())
            self.busniessButton.applyButtonStyle(.SecondaryLightGray())
        case .Business:
            self.userButton.applyButtonStyle(.SecondaryLightGray())
            self.busniessButton.applyButtonStyle(.OutlinedPurple())
        }
    }

    func setButtonAttribute() {
        let attributedTitle = NSMutableAttributedString(string: Strings.PRIVACY_AGREE_TITLE)
        attributedTitle.addAttribute(.foregroundColor, value: UIColor.color_8C4EFF, range: NSRange.init(location: 47, length: Strings.TERMS_TITLE.count))
        attributedTitle.addAttribute(.foregroundColor, value: UIColor.color_8C4EFF, range: NSRange.init(location: 68, length: Strings.POLICY_TITLE.count))
        self.privacyButton.setAttributedTitle(attributedTitle, for: .normal)
    }
}

private extension SignUpViewController {

    func validation() -> Bool {
        guard self.nameTextField.isInvalid else { return false }
        guard self.emailTextField.isInvalid else { return false }
        guard self.phoneTextField.isInvalid else { return false }
        guard self.passwordTextField.isInvalid else { return false }
        return true
    }

    func getAuth() -> UserModel {
        return .init(email: emailTextField.text, password: passwordTextField.text, name: nameTextField.text, countryCode: phoneTextField.countryCode, phone: phoneTextField.phone, type: self.type)
    }

    func signUp() {
        self.isEnableSignUp = false
        guard validation() else {
            self.isEnableSignUp = true
            return
        }
        _ = UserController().signUp(userModel: getAuth()).handlerDidFinishRequest {
            self.isEnableSignUp = true
        }.handlerofflineLoad {
            self.isEnableSignUp = true
        }
    }

}
