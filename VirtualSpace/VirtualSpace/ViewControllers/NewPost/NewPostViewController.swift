// _________SKAIK_MO_________
//
//  NewPostViewController.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 17/07/2023.
//

import UIKit
import IQKeyboardManagerSwift

class NewPostViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var superStack: UIStackView!
    @IBOutlet weak var newPostLabel: UILabel!
    @IBOutlet weak var authImage: rImage!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var lengthLabel: UILabel!
    @IBOutlet weak var postImage: rImage!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var postButton: UIButton!

    // MARK: Properties
    var handleBack: ((_ post: Post) -> Void)?
    private var postImg: UIImage?
    private let user = UserController().fetchUser()
    private var isEnablePost = true {
        didSet {
            self.postButton.isEnabled = isEnablePost
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
        IQKeyboardManager.shared.enable = false
        IQKeyboardManager.shared.enableAutoToolbar = false
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardNotificationWithoutSafeArea(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = true
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }

}

// MARK: - Actions
private extension NewPostViewController {
    @IBAction func postAction(_ sender: Any) {
        debugPrint(#function)
        self.addPost()
    }
    @IBAction func cameraAction(_ sender: Any) {
        debugPrint(#function)
        Helper.takeImage { image in
            self.postImage.image = image
            self.postImg = image
        }
    }
}

// MARK: - Configurations
private extension NewPostViewController {

    func setUpView() {
        let mask = self.view._roundCorners(isTopLeft: true, isTopRight: true)
        self.superStack.layer.maskedCorners = mask
        self.superStack.cornerRadius = 16
        self.textView.delegate = self
        self.setTextPlaceholder()
        self.postButton.applyButtonStyle(.Primary())
    }

    func setUpData() {
        self.newPostLabel.text = Strings.NEW_POST_TITLE
        self.authImage.fetchImage(user?.image, .ic_placeholder)
        self.postImage.image = nil
        self.postButton.title = Strings.POST_TITLE
    }

    func setTextPlaceholder() {
        textView.text = Strings.ASK_SOMTHING_PLACEHOLDER
        textView.textColor = .color_7A7A7A
    }

}

extension NewPostViewController: UITextViewDelegate {

    func textViewDidBeginEditing(_ textView: UITextView) {
        debugPrint(#function)
        if textView.textColor == .color_7A7A7A {
            textView.text = ""
            textView.textColor = .color_000000
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        debugPrint(#function)
        if textView.text.isEmpty {
            self.setTextPlaceholder()
        }
    }

    func textViewDidChange(_ textView: UITextView) {
        self.lengthLabel.text = "\(textView.text.count)/200"
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newValue = (textView.text as NSString?)?.replacingCharacters(in: range, with: text)
        if newValue?.count ?? 0 > 200 {
            textView.text = newValue
            self.lengthLabel.textColor = .color_FF0101
            return false
        } else {
            self.lengthLabel.textColor = .color_7A7A7A
            return true
        }
    }

}

extension NewPostViewController {

    func validation() -> Bool {
        guard NilValidationRule(field: Strings.DESCRIPTION_POST_MESSAGE).hasValidValue(self.textView.text) else { return false }
        guard self.textView.text != Strings.ASK_SOMTHING_PLACEHOLDER else {
            self._showErrorAlertOK(message: Strings.INVALID_DESCRIPTION_POST_MESSAGE)
            return false
        }
        guard self.textView.text?.count ?? 0 <= 200 else {
            self._showErrorAlertOK(message: Strings.INVALID_LENGTH_DESCRIPTION_POST_MESSAGE)
            return false
        }
        guard self.postImage.image != nil && self.postImg != nil else {
            self._showErrorAlertOK(message: Strings.ADD_PHOTO_MESSSAGE)
            return false
        }
        return true
    }

    func getPost() -> Post {
            .init(description: self.textView.text, user: self.user)
    }

    func addPost() {
        self.isEnablePost = false
        guard validation() else {
            self.isEnablePost = true
            return
        }
        _ = PostController().addPost(post: self.getPost(), image: self.postImg) { post in
            self.handleBack?(post)
            self._dismissVC()
        }.handlerDidFinishRequest {
            self.isEnablePost = true
        }.handlerofflineLoad {
            self.isEnablePost = true
        }

    }

}
