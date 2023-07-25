// _________SKAIK_MO_________
//
//  EditProfileViewController.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 12/07/2023.
//

import UIKit
import NKVPhonePicker

class EditProfileViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var authImage: UIImageView!
    @IBOutlet weak var authNameTextField: MainTextView!
    @IBOutlet weak var authEmailTextField: MainTextView!
    @IBOutlet weak var authPhoneTextField: PhoneTextFieldView!
    @IBOutlet weak var bioStack: UIStackView!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var bioTextView: UITextView!
    @IBOutlet weak var saveButton: UIButton!

    // MARK: Properties
    private let auth = UserController().fetchUser()
    private var image: UIImage?
    private var coverImg: UIImage?
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
private extension EditProfileViewController {

    @IBAction func saveAction(_ sender: Any) {
        debugPrint(#function)
        self.edit()
    }

    @objc func addCoverImage() {
        debugPrint(#function)
        Helper.takeImage { image in
            self.coverImage.image = image
            self.coverImg = image
        }
    }

    @objc func addImage() {
        debugPrint(#function)
        Helper.takeImage { image in
            self.authImage.image = image
            self.image = image
        }
    }
}

// MARK: - Configurations
private extension EditProfileViewController {

    func setUpView() {
        let coverGesture = UITapGestureRecognizer(target: self, action: #selector(addCoverImage))
        self.coverImage.addGestureRecognizer(coverGesture)
        let imageGesture = UITapGestureRecognizer(target: self, action: #selector(addImage))
        self.authImage.addGestureRecognizer(imageGesture)
        self.authNameTextField.setUpView(.Normal)
        self.authEmailTextField.setUpView(.Email)
        self.authPhoneTextField.setUpView(vc: self)
        self.bioStack.isHidden = self.auth?.type == .User ? true : false
        self.saveButton.applyButtonStyle(.Primary(40))
    }

    func setUpData() {
        self.title = Strings.EDIT_PROFILE_TITLE
        self.authNameTextField.title = Strings.NAME_TITLE
        self.authEmailTextField.title = Strings.EMAIL_TITLE
        self.authPhoneTextField.title = Strings.PHONE_NUM_TITLE
        self.bioLabel.text = Strings.BIO_TITLE
        self.saveButton.titleLabel?.text = Strings.SAVE_TITLE

        if let image = auth?.image, image._isValidValue {
            self.authImage.fetchImage(image, .ic_placeholder)
        } else {
            self.authImage.image = .ic_camera
        }
        self.coverImage.fetchImage(auth?.coverImage, .ic_placeholder)
        self.authNameTextField.textfield.text = auth?.name
        self.authEmailTextField.textfield.text = auth?.email
        self.authPhoneTextField.phone = auth?.phone
        self.authPhoneTextField.countryCode = auth?.countryCode
        self.bioTextView.text = auth?.bio
    }

    func fetchData() {

    }

}

private extension EditProfileViewController {

    func validation() -> Bool {
        guard self.authImage.image != nil && self.authImage.image != .ic_camera else {
            self._showErrorAlertOK(message: Strings.ADD_PHOTO_MESSSAGE)
            return false
        }
        guard self.coverImage.image != nil && self.coverImage.image != .ic_placeholder else {
            self._showErrorAlertOK(message: Strings.ADD_COVER_PHOTO_MESSSAGE)
            return false
        }
        guard self.authNameTextField.isInvalid else { return false }
        guard self.authEmailTextField.isInvalid else { return false }
        guard self.authPhoneTextField.isInvalid else { return false }
        if self.auth?.type == .Business {
            guard NilValidationRule(field: Strings.BIO_TITLE).hasValidValue(self.bioTextView.text) else { return false }
        }
        return true
    }

    func getAuth() -> UserModel? {
        guard let auth else { return nil }
        auth.name = authNameTextField.text
        auth.email = authEmailTextField.text
        auth.countryCode = authPhoneTextField.countryCode
        auth.phone = authPhoneTextField.text
        if auth.type == .Business {
            auth.bio = bioTextView.text
        }
        return auth
    }

    func edit() {
        self.isEnableSave = false
        guard validation(), let auth = getAuth() else {
            self.isEnableSave = true
            return
        }
        _ = UserController().editUser(user: auth, image: self.image, coverImage: self.coverImg, imageCompletion: { isCoverImage in
            if isCoverImage {
                self.coverImg = nil
            } else {
                self.image = nil
            }
        }).handlerDidFinishRequest(handler: {
            self.isEnableSave = true
        }).handlerofflineLoad(handler: {
            self.isEnableSave = true
        })
    }

}
