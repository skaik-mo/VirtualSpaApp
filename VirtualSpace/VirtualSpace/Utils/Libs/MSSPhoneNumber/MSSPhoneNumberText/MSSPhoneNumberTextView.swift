//_________SKAIK_MO_________
//
//  MSSPhoneNumberTextView.swift
//
//
//  Created by Mohammed Skaik on 06/08/2023.
//

import UIKit

class MSSPhoneNumberTextView: UIView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var phoneTextField: UITextField!

    private static var id = "MSSPhoneNumberTextView"
    private let mssPhoneNumber = MSSPhoneNumber()
    var withFlage = true
    private var country: Country? {
        didSet {
            self.setCode()
        }
    }
    var countryCode: String? {
        didSet {
            self.country = self.mssPhoneNumber.getCountry(code: countryCode ?? "US")
        }
    }
    var WithSelectedCountry = false {
        didSet {
            if self.WithSelectedCountry {
                let codeGesture = UITapGestureRecognizer(target: self, action: #selector(selectCode))
                self.codeLabel.addGestureRecognizer(codeGesture)
            }
        }
    }
    var phone: String? {
        get {
            return self.phoneTextField._getText
        }
        set {
            self.phoneTextField.text = newValue
        }
    }
    var title: String = "" {
        didSet {
            self.titleLabel.text = self.title
        }
    }
    var isInvalid: Bool {
        return PhoneValidator().hasValidValue(self.phone ?? "")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureXib()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureXib()
    }

    func configureXib() {
        let bundle = Bundle(for: MSSPhoneNumberTextView.self)
        contentView = UINib(nibName: MSSPhoneNumberTextView.id, bundle: bundle).instantiate(withOwner: self).first as? UIView
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.frame = bounds
        addSubview(contentView)
    }

    func setUpView(withFlage: Bool = true) {
        self.withFlage = withFlage
        self.WithSelectedCountry = true
        self.codeLabel.isUserInteractionEnabled = true
        self.phoneTextField.keyboardType = .numberPad
        self.phoneTextField.delegate = self
        self.phoneTextField.placeholder = "1xxxxx"
        self.phoneTextField._setAttributedPlaceholder(color: .color_7A7A7A, font: .poppinsRegular14)
    }

    private func setCode() {
        if let country {
            var code = ""
            if withFlage {
                code += "\(country.flag) "
            }
            code += "+\(country.dialCode)"
            self.codeLabel.text = code
        }
    }

    @objc private func selectCode() {
        let vc = MSSPhoneNumberPickerViewController()
        vc.getSelectedCountry = { country in
            self.countryCode = country.code
        }
        self.presentOnTopViewController(vc)
    }

}

extension MSSPhoneNumberTextView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? ""
        let maxLength = 10
        guard newText.count <= maxLength else { return false }
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
}

extension MSSPhoneNumberTextView {
    func presentOnTopViewController(_ viewControllerToPresent: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let topViewController = scene.windows.first?.rootViewController {
            var topPresentedViewController = topViewController
            while let presentedViewController = topPresentedViewController.presentedViewController {
                topPresentedViewController = presentedViewController
            }
            topPresentedViewController.present(viewControllerToPresent, animated: animated, completion: completion)
        }
    }
}
