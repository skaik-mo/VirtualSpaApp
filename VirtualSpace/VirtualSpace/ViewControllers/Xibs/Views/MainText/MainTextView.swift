//
//  MainTextView.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 10/07/2023.
//

import UIKit

class MainTextView: UIView {

    // MARK: Outlets
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textfield: UITextField!

    // MARK: Properties
    var style: MainFieldStyle = .Normal
    var title: String = "" {
        didSet {
            self.label.text = self.title
            self.textfield.placeholder = self.title
        }
    }
    var isInvalid: Bool {
        switch style {
        case .Email:
            return EmailValidator().hasValidValue(self.textfield._getText)
        default:
            return NilValidationRule(field: self.label.text ?? "").hasValidValue(self.textfield._getText)
        }
    }
    var text: String {
        self.textfield._getText
    }

    enum MainFieldStyle {
        case Normal, Email
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
        let bundle = Bundle(for: MainTextView.self)
        contentView = UINib(nibName: MainTextView._id, bundle: bundle).instantiate(withOwner: self).first as? UIView
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.frame = bounds
        addSubview(contentView)
    }

    func setUpView(_ style: MainFieldStyle) {
        self.style = style
        self.textfield._setAttributedPlaceholder(color: .color_7A7A7A, font: .poppinsRegular14)
        self.setKeyboardType()
    }

    private func setKeyboardType() {
        switch style {
        case .Normal:
            self.textfield.keyboardType = .default
        case .Email:
            self.textfield.keyboardType = .emailAddress
        }
    }

}
