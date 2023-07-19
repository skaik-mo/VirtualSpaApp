//
//  Helper.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 13/07/2023.
//

import Foundation
import UIKit
import ProgressHUD

class Helper {

    static private var picker: MSSTakeImage?

    static func takeImage(getImage: ((UIImage) -> Void)?) {
        guard let parent = SceneDelegate.shared?.rootNavigationController?._topMostViewController else { return }
        picker = MSSTakeImage(presentationController: parent)
        picker?.present { image in
            getImage?(image)
        }
    }

    static func call(_ phone: String) {
        guard let url = URL(string: "tel://\(phone)"), UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url)
    }

    static func showLoader(isLoding: Bool, progress: Float? = nil) {
        if let progress, isLoding {
            ProgressHUD.showIndicatorProgress(progress)
            return
        }
        if isLoding {
            ProgressHUD.showIndicator()
        } else {
            ProgressHUD.dismissIndicator()
        }
    }

    static func clearUserDefaults() {
        if let appDomain = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: appDomain)
        }
    }
}
