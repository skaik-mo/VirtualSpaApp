//
//  UIButton+style.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 09/07/2023.
//

import Foundation
import UIKit

// MARK: - TextField style
extension UIButton {
    enum ButtonStyle {
        case Primary
        case SecondaryLightPurple
        case SecondaryLightGray
        case SecondaryGreen
        case SecondaryRed
        case OutlinedWhite
        case OutlinedPurple

        var height: CGFloat {
            switch self {
            case .Primary, .OutlinedWhite, .SecondaryLightPurple:
                return 40.0
            case .OutlinedPurple, .SecondaryLightGray:
                return 36.0
            case .SecondaryGreen, .SecondaryRed:
                return 28
            }
        }

        var borderWidth: CGFloat {
            switch self {
            case .OutlinedWhite, .OutlinedPurple:
                return 1
            default:
                return 0
            }
        }

        var borderColor: UIColor {
            switch self {
            case .OutlinedWhite:
                return .color_FFFFFF
            case .OutlinedPurple:
                return .color_8C4EFF
            default:
                return .clear
            }
        }

        var buttonBackgroundColor: UIColor {
            switch self {
            case .Primary:
                return .color_8C4EFF
            case .SecondaryLightPurple:
                return .color_8C4EFF.withAlphaComponent(0.1)
            case .SecondaryLightGray:
                return .color_FAF9FD
            case .SecondaryGreen:
                return .color_18B58C
            case .SecondaryRed:
                return .color_FF0101
            case .OutlinedWhite, .OutlinedPurple:
                return .clear
            }
        }

        var titleColor: UIColor {
            switch self {
            case .Primary, .SecondaryRed, .SecondaryGreen, .OutlinedWhite:
                return .color_FFFFFF
            case .SecondaryLightGray:
                return .color_000000
            case .SecondaryLightPurple, .OutlinedPurple:
                return .color_8C4EFF
            }
        }

        var font: UIFont {
            return .poppinsMedium13
        }

        func setCorner(_ height: CGFloat) -> CGFloat {
            switch self {
            case .Primary, .SecondaryLightPurple, .SecondaryLightGray, .OutlinedWhite, .OutlinedPurple:
                return height / 2
            case .SecondaryGreen, .SecondaryRed:
                return 10
            }
        }
    }
}

extension UIButton {

    @IBInspectable var selectedImage: UIImage? {
        get {
            return self.image(for: .normal)
        }
        set {
            self.setImage(newValue, for: .selected)
        }
    }

    func applyButtonStyle(_ style: ButtonStyle) {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: style.height)
            ])
        self.cornerRadius = style.setCorner(self.frame.height)
        self.backgroundColor = style.buttonBackgroundColor
        self.borderColor = style.borderColor
        self.borderWidth = style.borderWidth
        self._setAttributedTitle(style)
    }

    func _setAttributedTitle(_ style: ButtonStyle) {
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
