//_________SKAIK_MO_________
//
//  ChangePasswordViewController.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 12/07/2023.
//

import UIKit

class ChangePasswordViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var currentPasswordTextField: PasswordTextFieldView!
    @IBOutlet weak var newPassworTextField: PasswordTextFieldView!
    @IBOutlet weak var repeatPassworTextField: PasswordTextFieldView!
    @IBOutlet weak var saveButton: UIButton!
    
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
        fetchData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

}

// MARK: - Actions
private extension ChangePasswordViewController {

    @IBAction func saveAction(_ sender: Any) {
        debugPrint(#function)
    }
}

// MARK: - Configurations
private extension ChangePasswordViewController {

    func setUpView() {
        self.currentPasswordTextField.setUpView()
        self.newPassworTextField.setUpView()
        self.repeatPassworTextField.setUpView()
        self.saveButton.applyButtonStyle(.Primary(40))
    }

    func setUpData() {
        self.title = Strings.CHANGE_PASS_TITLE
        self.currentPasswordTextField.title = Strings.CURRENT_PASS_TITLE
        self.currentPasswordTextField.placeholder = Strings.PASSWORD_TITLE
        self.newPassworTextField.title = Strings.NEW_PASS_TITLE
        self.newPassworTextField.placeholder = Strings.PASSWORD_TITLE
        self.repeatPassworTextField.title = Strings.REPEAT_PASS_TITLE
        self.repeatPassworTextField.placeholder = Strings.PASSWORD_TITLE
        self.saveButton.titleLabel?.text = Strings.SAVE_TITLE
    }

    func fetchData() {

    }

}

