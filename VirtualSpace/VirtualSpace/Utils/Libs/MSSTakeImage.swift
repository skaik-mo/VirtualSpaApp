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
    var pickerController = UIImagePickerController()
    var presentationController: UIViewController?

    init(presentationController: UIViewController) {
        super.init()
        self.presentationController = presentationController
    }


    func present(getImage: ((UIImage) -> Void)?) {
//        if UIImagePickerController.isSourceTypeAvailable(.camera) {
//            self.pickerController.sourceType = .camera
//        } else {
        self.pickerController.sourceType = .photoLibrary
//        }
        self.pickerController.delegate = self
        self.pickerController.allowsEditing = true
        self.getImage = getImage
        self.presentationController?.present(self.pickerController, animated: true, completion: nil)
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
