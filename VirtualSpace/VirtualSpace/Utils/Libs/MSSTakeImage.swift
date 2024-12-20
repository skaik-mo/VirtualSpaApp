// _________SKAIK_MO_________
//
//  TakeImage.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 17/07/2023.
//

import Foundation
import UIKit

class MSSTakeImage: NSObject {

    private var getImage: ((UIImage) -> Void)?
    let CHOOSE_TITLE = "Choose"
    let CAMERA_TITLE = "Camera"
    let GALLERY_TITLE = "Gallery"
    let CANCEL_TITLE = Strings.CANCEL_TITLE
    var pickerController = UIImagePickerController()

    private func selectedType() {
        let alert = UIAlertController(title: CHOOSE_TITLE, message: nil, preferredStyle: .alert)
        let cameraAction = UIAlertAction(title: CAMERA_TITLE, style: .default) { _ in
            self.pickerController.sourceType = .camera
            self.pickerController._presentVC()
        }
        let libraryAction = UIAlertAction(title: GALLERY_TITLE, style: .default) { _ in
            self.pickerController.sourceType = .photoLibrary
            self.pickerController._presentVC()
        }
        let cancelAction = UIAlertAction(title: CANCEL_TITLE, style: .cancel)
        alert.addAction(cameraAction)
        alert.addAction(libraryAction)
        alert.addAction(cancelAction)
        alert._presentVC()
    }

    func present(getImage: ((UIImage) -> Void)?) {
        self.pickerController.delegate = self
        self.pickerController.allowsEditing = true
        self.getImage = getImage
        self.selectedType()
    }
}

extension MSSTakeImage: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        debugPrint(#function)
        pickerController.dismiss(animated: true)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let image = info[.editedImage] as? UIImage else {
            return
        }
        self.getImage?(image)
        pickerController.dismiss(animated: true)
    }
}
