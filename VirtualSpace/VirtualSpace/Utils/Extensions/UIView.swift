// _________SKAIK_MO_________
//
//  UIView.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 09/07/2023.
//

import Foundation
import UIKit

extension UIView {

    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
        }
    }

    @IBInspectable var borderColor: UIColor {
        get {
            return .gray
        }
        set {
            self.layer.borderColor = newValue.cgColor
        }
    }

    @IBInspectable var borderWidth: CGFloat {
        get {
            return self.layer.borderWidth
        }
        set {
            self.layer.borderWidth = newValue
        }
    }

    @IBInspectable var shadowColor: UIColor {
        get {
            return .gray

        }
        set {
            self.layer.shadowColor = newValue.cgColor
        }
    }

    @IBInspectable var shadowOffset: CGSize {
        get {
            return self.layer.shadowOffset
        }
        set {
            self.layer.shadowOffset = newValue
        }
    }

    @IBInspectable var shadowRadius: CGFloat {
        get {
            return self.layer.shadowRadius
        }
        set {
            self.layer.shadowRadius = newValue
        }
    }
    @IBInspectable var shadowOpacity: Float {
        get {
            return self.layer.shadowOpacity
        }
        set {
            self.layer.shadowOpacity = newValue
        }
    }

    func _roundCorners(isTopLeft: Bool = false, isTopRight: Bool = false, isBottomLeft: Bool = false, isBottomRight: Bool = false) -> CACornerMask {
        var corners: CACornerMask = []

        var isTopLeftCorner: Bool = isTopLeft
        var isTopRightCorner: Bool = isTopRight
        var isBottomLeftCorner: Bool = isBottomLeft
        var isBottomRightCorner: Bool = isBottomRight

        if UIApplication.shared.userInterfaceLayoutDirection == .rightToLeft {
            let tl = isTopLeftCorner
            let tr = isTopRightCorner
            let bl = isBottomLeftCorner
            let br = isBottomRightCorner

            isTopLeftCorner = tr
            isTopRightCorner = tl
            isBottomLeftCorner = br
            isBottomRightCorner = bl
        }
        if isTopLeftCorner {
            corners.insert(.layerMinXMinYCorner)
        }

        if isTopRightCorner {
            corners.insert(.layerMaxXMinYCorner)
        }
        if isBottomLeftCorner {
            corners.insert(.layerMinXMaxYCorner)
        }
        if isBottomRightCorner {
            corners.insert(.layerMaxXMaxYCorner)
        }
        return corners
    }

}
