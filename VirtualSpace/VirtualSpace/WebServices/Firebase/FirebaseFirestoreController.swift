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
        guard Reachability.shared.isConnected() else {
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
        guard Reachability.shared.isConnected() else {
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

    func getDocuments(isShowLoder: Bool = true, isShowMessage: Bool = true, success: @escaping ((_ objects: [Any]) -> Void)) -> Self {
        guard Reachability.shared.isConnected(isShowMessage: isShowMessage) else {
            DispatchQueue.main.async {
                self.offlineLoad?()
            }
            return self
        }
        if isShowLoder {
            Helper.showLoader(isLoding: true)
        }
        reference?.getDocuments(completion: { response, error in
            guard ResponseHandler.responseHandler(error: error, isShowMessage: isShowMessage) else {
                self.didFinishRequest?()
                return
            }
            if isShowLoder {
                Helper.showLoader(isLoding: false)
            }
            var objects: [Any] = []
            response?.documents.forEach({ data in
                var dictionary = data.data()
                dictionary["id"] = data.documentID
                objects.append(dictionary)
            })
            success(objects)
            self.didFinishRequest?()
        })
        return self
    }

    func searchWithDocumentIDs(documentIDs: [String], isShowLoder: Bool = true, isShowMessage: Bool = true, success: @escaping ((_ objects: [Any]) -> Void)) -> Self {
        guard Reachability.shared.isConnected(isShowMessage: isShowMessage) else {
            DispatchQueue.main.async {
                self.offlineLoad?()
            }
            return self
        }
        if isShowLoder {
            Helper.showLoader(isLoding: true)
        }
        reference?.whereField(FieldPath.documentID(), in: documentIDs).getDocuments(completion: { response, error in
            guard ResponseHandler.responseHandler(error: error, isShowMessage: isShowMessage) else {
                self.didFinishRequest?()
                return
            }
            if isShowLoder {
                Helper.showLoader(isLoding: false)
            }
            var objects: [Any] = []
            response?.documents.forEach({ data in
                var dictionary = data.data()
                dictionary["id"] = data.documentID
                objects.append(dictionary)
            })
            success(objects)
            self.didFinishRequest?()
        })
        return self
    }

    func fetchDocuments(limit: Int, isShowLoder: Bool = true, lastDocument: QueryDocumentSnapshot?, completion: @escaping ((_ dic: [[String: Any]], _ lastDocument: QueryDocumentSnapshot?) -> Void)) -> Self {
        guard Reachability.shared.isConnected(isShowMessage: false) else {
            DispatchQueue.main.async {
                self.offlineLoad?()
            }
            return self
        }
        if isShowLoder {
            Helper.showLoader(isLoding: true)
        }
        var arrayOfDic: [[String: Any]] = []
        var query: Query? = reference?.limit(to: limit)
        if let lastDocument {
            query = query?.start(afterDocument: lastDocument)
        }
        query?.getDocuments { response, error in
            guard ResponseHandler.responseHandler(error: error) else { self.didFinishRequest?()
                ; return }
            for dictionary in response?.documents ?? [] {
                let dictionary = dictionary.data()
                arrayOfDic.append(dictionary)
            }
            if isShowLoder {
                Helper.showLoader(isLoding: false)
            }
            if let lastDocument = response?.documents.last {
                completion(arrayOfDic, lastDocument)
                self.didFinishRequest?()
                return
            }
            completion(arrayOfDic, nil)
            self.didFinishRequest?()
        }
        return self
    }

    func deleteDocument(document: String, isShowLoder: Bool = true, isShowMessage: Bool = true, success: @escaping () -> Void) {
        guard Reachability.shared.isConnected() else { return }
        if isShowLoder {
            Helper.showLoader(isLoding: true)
        }
        reference?.document(document).delete(completion: { error in
            guard ResponseHandler.responseHandler(error: error) else { return }
            if isShowLoder {
                Helper.showLoader(isLoding: false)
            }
            success()
            self.didFinishRequest?()
        })
    }

}
