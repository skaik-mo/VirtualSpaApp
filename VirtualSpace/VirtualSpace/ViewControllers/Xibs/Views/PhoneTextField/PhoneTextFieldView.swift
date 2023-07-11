//
//  PhoneTextFieldView.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 10/07/2023.
//

import UIKit
import NKVPhonePicker

class PhoneTextFieldView: UIView {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField: NKVPhonePickerTextField!
    var title: String = "" {
        didSet {
            self.label.text = self.title
        }
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
        let bundle = Bundle(for: PhoneTextFieldView.self)
        contentView = UINib(nibName: PhoneTextFieldView._id, bundle: bundle).instantiate(withOwner: self).first as? UIView
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.frame = bounds
        addSubview(contentView)
    }

    func setUpView(vc: UIViewController) {
        self.textField.countryPickerDelegate = self
        self.textField.phonePickerDelegate = vc
        self.textField.placeholder = "1xxxxx"
        let country = Country.country(for: NKVSource(countryCode: "PS"))
        self.textField.country = country
    }


}

extension PhoneTextFieldView: CountriesViewControllerDelegate {
    func countriesViewController(_ sender: CountriesViewController, didSelectCountry country: Country) {
        print("✳️ Did select country: \(country)")
    }

    func countriesViewControllerDidCancel(_ sender: CountriesViewController) {
        print("😕")
    }
}
