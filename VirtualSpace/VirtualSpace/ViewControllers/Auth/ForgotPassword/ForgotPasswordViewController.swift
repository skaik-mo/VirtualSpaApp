// _________SKAIK_MO_________
//
//  ForgotPasswordViewController.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 11/07/2023.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var forgotPasswordLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var emailTextField: MainTextView!
    @IBOutlet weak var sendButton: UIButton!

    // MARK: Properties
    private var isEnableSend = true {
        didSet {
            self.sendButton.isEnabled = isEnableSend
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
private extension ForgotPasswordViewController {
    @IBAction func sendAction(_ sender: Any) {
        self.send()
    }
}

// MARK: - Configurations
private extension ForgotPasswordViewController {

    func setUpView() {
        self.emailTextField.setUpView(.Email)
        self.sendButton.applyButtonStyle(.Primary())
    }

    func setUpData() {
        self.view.cornerRadius = 25
        self.forgotPasswordLabel.text = Strings.FORGOT_PASSWORD_TITLE
        self.descriptionLabel.text = Strings.FILL_DATA_TITLE
        self.emailTextField.title = Strings.EMAIL_TITLE
        self.sendButton.titleLabel?.text = Strings.SEND_TITLE
    }

}

private extension ForgotPasswordViewController {

    func validation() -> Bool {
        return self.emailTextField.isInvalid
    }

    func send() {
        self.isEnableSend = false
        guard validation() else {
            self.isEnableSend = true
            return
        }
        _ = UserController().passwordReset(emailTextField.text).handlerDidFinishRequest {
            self.isEnableSend = true
        }.handlerofflineLoad {
            self.isEnableSend = true
        }
    }

}
