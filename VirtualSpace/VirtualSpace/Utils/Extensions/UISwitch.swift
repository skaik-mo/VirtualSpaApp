//
//  UISwitch.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 11/07/2023.
//

import Foundation
import UIKit

extension UISwitch {

    func setScaleThumb(_ scaleX: CGFloat, _ scaleY: CGFloat) {
        if let thumb = self.subviews[0].subviews[1].subviews[2] as? UIImageView {
            thumb.transform = CGAffineTransformMakeScale(scaleX, scaleY)
        }
    }

    func setScale(_ scaleX: CGFloat, _ scaleY: CGFloat) {
        self.transform = CGAffineTransformMakeScale(scaleX, scaleY)
    }
}
