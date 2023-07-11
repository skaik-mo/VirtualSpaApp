//_________SKAIK_MO_________
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
        debugPrint(#function)
    }
}

// MARK: - Configurations
private extension ForgotPasswordViewController {

    func setUpView() {
        self.emailTextField.setUpView(.Email)
        self.sendButton.applyButtonStyle(.Primary)
    }

    func setUpData() {
        self.view.cornerRadius = 25
        self.forgotPasswordLabel.text = Strings.FORGOT_PASSWORD_TITLE
        self.descriptionLabel.text = Strings.FILL_DATA_TITLE
        self.emailTextField.title = Strings.EMAIL_TITLE
        self.sendButton.titleLabel?.text = Strings.SEND_TITLE
    }

}

