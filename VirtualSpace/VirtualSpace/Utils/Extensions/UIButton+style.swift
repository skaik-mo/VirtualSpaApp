//
//  UIButton+style.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 09/07/2023.
//

import Foundation
import UIKit

extension UIButton {

    @IBInspectable var selectedImage: UIImage? {
        get {
            return self.image(for: .normal)
        }
        set {
            self.setImage(newValue, for: .selected)
        }
    }

    func applyButtonStyle(_ style: GlobalConstants.ButtonStyle) {
        let height = style.height
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: height)
            ])
        self.cornerRadius = style.setCorner(height)
        self.backgroundColor = style.buttonBackgroundColor
        self.borderColor = style.borderColor
        self.borderWidth = style.borderWidth
        self._setAttributedTitle(style)
        self.contentEdgeInsets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14) // for iOS 14
    }

    func _setAttributedTitle(_ style: GlobalConstants.ButtonStyle) {
        let attribute = NSAttributedString(string: self.titleLabel?.text ?? "", attributes: [NSAttributedString.Key.foregroundColor: style.titleColor, NSAttributedString.Key.font: style.font])
        self.setAttributedTitle(attribute, for: .normal)
    }

    func _underline() {
        guard let title = self.titleLabel else { return }
        guard let tittleText = title.text else { return }
        let attributedString = NSMutableAttributedString(string: (tittleText))
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: tittleText.count))
        self.setAttributedTitle(attributedString, for: .normal)
    }
}
