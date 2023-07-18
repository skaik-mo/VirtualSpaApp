// _________SKAIK_MO_________
//
//  EditProfileViewController.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 12/07/2023.
//

import UIKit

class EditProfileViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var authImage: UIImageView!
    @IBOutlet weak var authNameTextField: MainTextView!
    @IBOutlet weak var authEmailTextField: MainTextView!
    @IBOutlet weak var authPhoneTextField: PhoneTextFieldView!
    @IBOutlet weak var bioStack: UIStackView!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var bioTextView: UITextView!
    @IBOutlet weak var saveButton: UIButton!

    // MARK: Properties
    private var auth = AuthController().fetchAuth()

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
private extension EditProfileViewController {

    @IBAction func saveAction(_ sender: Any) {
        debugPrint(#function)
    }

    @objc func selectImage() {
        debugPrint(#function)
        Helper.takeImage { image in
            self.authImage.image = image
        }
    }
}

// MARK: - Configurations
private extension EditProfileViewController {

    func setUpView() {
        let imageGesture = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        self.authImage.addGestureRecognizer(imageGesture)
        self.authNameTextField.setUpView(.Normal)
        self.authEmailTextField.setUpView(.Email)
        self.authPhoneTextField.setUpView(vc: self)
        self.bioStack.isHidden = self.auth == .User ? true : false
        self.saveButton.applyButtonStyle(.Primary(40))
    }

    func setUpData() {
        self.title = Strings.EDIT_PROFILE_TITLE
        self.authImage.image = .ic_camera
        self.authNameTextField.title = Strings.NAME_TITLE
        self.authEmailTextField.title = Strings.EMAIL_TITLE
        self.authPhoneTextField.title = Strings.PHONE_NUM_TITLE
        self.bioLabel.text = Strings.BIO_TITLE
        self.saveButton.titleLabel?.text = Strings.SAVE_TITLE
    }

    func fetchData() {

    }

}
