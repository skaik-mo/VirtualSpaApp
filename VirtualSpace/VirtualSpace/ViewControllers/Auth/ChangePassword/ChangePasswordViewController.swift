// _________SKAIK_MO_________
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
    let auth = UserController().fetchUser()
    private var isEnableSave = true {
        didSet {
            self.saveButton.isEnabled = isEnableSave
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
        self.save()
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

private extension ChangePasswordViewController {

    func validation() -> Bool {
        guard self.currentPasswordTextField.isInvalid else { return false }
        guard self.newPassworTextField.isInvalid else { return false }
        guard self.repeatPassworTextField.isInvalid else { return false }
        guard currentPasswordTextField.text == auth?.password else {
            self._showErrorAlertOK(message: Strings.CURRENT_PASS_INCORRECT_MESSAGE)
            return false
        }
        guard currentPasswordTextField.text != newPassworTextField.text else {
            self._showErrorAlertOK(message: Strings.NOT_SAME_PASS_MESSAGE)
            return false
        }
        guard newPassworTextField.text == repeatPassworTextField.text else {
            self._showErrorAlertOK(message: Strings.SAME_PASS_MESSAGE)
            return false
        }
        return true
    }

    func clearData() {
        self.currentPasswordTextField.clear()
        self.newPassworTextField.clear()
        self.repeatPassworTextField.clear()
    }

    func getAuth() -> UserModel? {
        guard let auth else { return nil }
        auth.password = self.newPassworTextField.text
        return auth
    }

    func save() {
        self.isEnableSave = false
        guard validation(), let auth = getAuth() else {
            self.isEnableSave = true
            return
        }
        _ = UserController().changePassword(user: auth).handlerDidFinishRequest(handler: {
            self.isEnableSave = true
            self.clearData()
        }).handlerofflineLoad(handler: {
            self.isEnableSave = true
        })
    }

}
