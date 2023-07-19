//
//  FirebaseFirestoreController.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 19/07/2023.
//

import Foundation
import FirebaseFirestore

class FirebaseFirestoreController: HandlerFinish {
    private var reference: CollectionReference?
    var didFinishRequest: (() -> Void)?
    var offlineLoad: (() -> Void)?

    func handlerDidFinishRequest(handler: (() -> Void)?) -> Self {
        self.didFinishRequest = handler
        return self
    }

    func handlerofflineLoad(handler: (() -> Void)?) -> Self {
        self.offlineLoad = handler
        return self
    }

    func setFirebaseReference(_ collectionReference: GlobalConstants.Collection) -> Self {
        self.reference = Firestore.firestore().collection(collectionReference.rawValue)
        return self
    }

    func setData(document: String, dictionary: [String: Any], isShowLoder: Bool = true, isShowMessage: Bool = true, success: @escaping () -> Void) -> Self {
        guard Reachability.shared.isConnected else {
            self.offlineLoad?()
            return self
        }
        if isShowLoder {
            Helper.showLoader(isLoding: true)
        }
        reference?.document(document).setData(dictionary, completion: { error in
            self.didFinishRequest?()
            guard ResponseHandler.responseHandler(error: error) else { return }
            success()
            if isShowLoder {
                Helper.showLoader(isLoding: false)
            }
        })
        return self
    }

    func getDocument(document: String, isShowLoder: Bool = true, isShowMessage: Bool = true, success: @escaping (_ dictionary: [String: Any]?) -> Void) -> Self {
        guard Reachability.shared.isConnected else {
            self.offlineLoad?()
            return self
        }
        if isShowLoder {
            Helper.showLoader(isLoding: true)
        }
        reference?.document(document).getDocument { response, error in
            self.didFinishRequest?()
            guard ResponseHandler.responseHandler(error: error) else { return }
            let data = response?.data() as? [String: Any]
            success(data)
            if isShowLoder {
                Helper.showLoader(isLoding: false)
            }
        }
        return self
    }
}

// extension DocumentReference {
//    func getDocument(completion: @escaping ((_ dictionary: [String: Any]?) -> Void)) {
//        self.getDocument { response, error in
//            guard !ResponseHandler.responseHandler(error: error) else {
//                completion(nil)
//                return
//            }
//            let data = response?.data() as? [String: Any]
//            completion(data)
//        }
//    }
// }

// extension Query {
//    func getDocuments(completion: @escaping ((_ dictionary: [[String: Any]]) -> Void)) {
//        self.getDocuments { response, error in
//            guard !ResponseHandler.responseHandler(error: error) else {
//                completion([])
//                return
//            }
//
//            let dictionary: [[String: Any]] = response?.documents.map({ data in
//                return data.data()
//            }) ?? []
//            completion(dictionary)
//
//        }
//    }
// }
