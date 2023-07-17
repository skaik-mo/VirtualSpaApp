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
    var or: MSSTakeImage?

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
    }
    @IBAction func cameraAction(_ sender: Any) {
        debugPrint(#function)
        Helper.takeImage { image in
            self.postImage.image = image
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
        self.postButton.applyButtonStyle(.Primary(40))
    }

    func setUpData() {
        self.newPostLabel.text = Strings.NEW_POST_TITLE
        self.authImage.image = .demo
        self.postImage.image = nil
        self.lengthLabel.text = "0/200"
        self.postButton.titleLabel?.text = Strings.POST_TITLE
    }

    func fetchData() {

    }

    func setTextPlaceholder() {
//        if self.object == nil {
        textView.text = Strings.ASK_SOMTHING_PLACEHOLDER
        textView.textColor = .color_7A7A7A
//        } else {
//        textView.textColor = .color_000000
//        }
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

}
