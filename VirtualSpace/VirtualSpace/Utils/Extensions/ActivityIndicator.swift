//
//  ActivityIndicator.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 19/07/2023.
//

import Foundation
import ProgressHUD

extension ProgressHUD {

    class func showIndicator() {
        ProgressHUD.show(interaction: false)
        ProgressHUD.colorAnimation = .color_8C4EFF
        ProgressHUD.animationType = .circleSpinFade
    }

    class func showIndicatorProgress(_ progress: Float) {
        ProgressHUD.colorAnimation = .color_8C4EFF
        ProgressHUD.colorProgress = .color_8C4EFF
        ProgressHUD.animationType = .circleSpinFade
        ProgressHUD.showProgress(CGFloat(progress))
    }

    class func dismissIndicator() {
        ProgressHUD.dismiss()
    }
}
