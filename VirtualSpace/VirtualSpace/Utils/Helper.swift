//
//  Helper.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 13/07/2023.
//

import Foundation
import UIKit
import YPImagePicker

class Helper {

    static func call(_ phone: String) {
        guard let url = URL(string: "tel://\(phone)"), UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url)
    }

    class func takeImage(handler: @escaping (_ image: UIImage, _ latitude: Double, _ longitude: Double) -> Void) {
        var config = YPImagePickerConfiguration()
        config.showsPhotoFilters = false
        config.albumName = "Nature Palestine Society"
        config.showsCrop = .none
        config.overlayView = UIView()
        let picker = YPImagePicker(configuration: config)
        picker.didFinishPicking { [unowned picker] items, _ in
            if let photo = items.singlePhoto {
                var latitude = 0.0
                var longitude = 0.0
                if let gps = photo.exifMeta?["{GPS}"] as? [String: Any], let lat = gps["Latitude"] as? Double, let long = gps["Longitude"] as? Double {
                    latitude = lat
                    longitude = long
                }
                handler(photo.image, latitude, longitude)
            }
            picker.dismiss(animated: true, completion: nil)
        }
        SceneDelegate.shared?.rootNavigationController?.topViewController?.present(picker, animated: true, completion: nil)
    }

}
