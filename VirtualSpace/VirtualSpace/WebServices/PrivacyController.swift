//
//  PrivacyController.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 20/08/2023.
//

import Foundation

class PrivacyController {

    private let referance: FirebaseFirestoreController = FirebaseFirestoreController().setFirebaseReference(.Settings)
    private let privacyKey = "PRIVACY"

    func getPrivacy(handlerResponse: @escaping ((_ value: String?) -> Void)) -> FirebaseFirestoreController {
        return referance.fetchDocument(document: privacyKey, isShowLoader: false) { dictionary in
            if let value = dictionary?["value"] as? String, !value.isEmpty {
                handlerResponse(value)
                return
            }
            handlerResponse(nil)
        }
    }

}
