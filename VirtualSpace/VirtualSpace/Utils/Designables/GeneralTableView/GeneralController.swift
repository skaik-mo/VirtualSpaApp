//
//  GeneralController.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 22/07/2023.
//

import UIKit

enum GeneralController {
    case GetTest

    func getFunc(pageNumber: Int, isShowLoader: Bool, handlerResponse: @escaping ((_ objects: [Any], _ totalPages: Int, _ pageNumber: Int, _ headerObject: Any?) -> Void)) -> FirebaseFirestoreController? {
        switch self {
        case .GetTest:
            return TestController().getTests(pageNumber: 0, isShowLoader: isShowLoader, handlerResponse: handlerResponse, handlerOfflineLoad: nil)
        }
    }
}

class TestController {

    private let reference = FirebaseFirestoreController().setFirebaseReference(.Test)

    func getTests(pageNumber: Int, isShowLoader: Bool, handlerResponse: @escaping ((_ objects: [Any], _ totalPages: Int, _ pageNumber: Int, _ headerObject: Any?) -> Void), handlerOfflineLoad: (() -> Void)?) -> FirebaseFirestoreController? {
        return reference.getDocuments(isShowLoder: isShowLoader) { objects in

            handlerResponse(objects, 0, 0, nil)
        }
//        .handlerofflineLoad(handler: handlerOfflineLoad)
    }

}
