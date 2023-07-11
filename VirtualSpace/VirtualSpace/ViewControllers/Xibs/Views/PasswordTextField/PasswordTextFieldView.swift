//
//  PasswordTextFieldView.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 10/07/2023.
//

import UIKit

class PasswordTextFieldView: UIView {

    // MARK: Outlets
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textfield: UITextField!
    @IBOutlet weak var iconButton: UIButton!

    // MARK: Properties
    private var isSecure = true {
        didSet {
            self.iconButton.isSelected = !isSecure
            self.textfield.isSecureTextEntry = isSecure
        }
    }
    var title: String = "" {
        didSet {
            self.label.text = self.title
            self.textfield.placeholder = self.title
        }
    }
    var isInvalid: Bool {
        return CharacterCountValidationRule(field: Strings.PASSWORD_TITLE, minCount: 6, maxCount: nil).hasValidValue(self.textfield._getText)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureXib()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureXib()
    }

    private func configureXib() {
        let bundle = Bundle(for: PasswordTextFieldView.self)
        contentView = UINib(nibName: PasswordTextFieldView._id, bundle: bundle).instantiate(withOwner: self).first as? UIView
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.frame = bounds
        addSubview(contentView)
    }

    func setUpView() {
        self.isSecure = true
        self.textfield._setAttributedPlaceholder(color: .color_7A7A7A, font: .poppinsRegular14)
    }

    @IBAction func iconAction(_ sender: Any) {
        self.isSecure.toggle()
    }


}
