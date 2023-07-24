//
//  GeneralController.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 22/07/2023.
//

import UIKit
import FirebaseFirestore

enum GeneralController {
    case GetTest

    func sendRequest(lastDocument: QueryDocumentSnapshot?, isShowLoader: Bool, handlerResponse: @escaping ((_ objects: [Any], _ lastDocuments: QueryDocumentSnapshot?, _ headerObject: Any?) -> Void)) -> FirebaseFirestoreController? {
        switch self {
        case .GetTest:
            return TestController().getTest(lastDocument: lastDocument, isShowLoader: isShowLoader, handlerResponse: handlerResponse, handlerOfflineLoad: nil)
        }
    }
}

class TestController {

    private let reference = FirebaseFirestoreController().setFirebaseReference(.Test)

    func getTest(lastDocument: QueryDocumentSnapshot?, isShowLoader: Bool, handlerResponse: @escaping ((_ objects: [Any], _ lastDocuments: QueryDocumentSnapshot?, _ headerObject: Any?) -> Void), handlerOfflineLoad: (() -> Void)?) -> FirebaseFirestoreController? {
        return reference.fetchDocuments(limit: 4, isShowLoder: isShowLoader, lastDocument: lastDocument) { dic, lastDocument in
            guard let lastDocument = lastDocument else { handlerResponse([], nil, nil); return }
            handlerResponse(dic, lastDocument, nil)
        }
    }

}
