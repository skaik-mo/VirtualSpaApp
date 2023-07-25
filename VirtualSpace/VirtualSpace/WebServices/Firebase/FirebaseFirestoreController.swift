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

    func fetchDocumentsWithDocumentIDs(documentIDs: [String], limit: Int, lastDocument: QueryDocumentSnapshot?, isShowLoder: Bool = true, isShowMessage: Bool = true, completion: @escaping ((_ objects: [[String: Any]], _ lastDocument: QueryDocumentSnapshot?) -> Void)) -> Self {
        guard !documentIDs.isEmpty else {
            completion([], nil)
            DispatchQueue.main.async {
                self.didFinishRequest?()
            }
            return self
        }
        guard Reachability.shared.isConnected(isShowMessage: false) else {
            DispatchQueue.main.async {
                self.offlineLoad?()
            }
            return self
        }
        if isShowLoder {
            Helper.showLoader(isLoding: true)
        }
        var objects: [[String: Any]] = []
        var query: Query? = reference?.limit(to: limit)
        if let lastDocument {
            query = query?.start(afterDocument: lastDocument)
        }
        query?.whereField(FieldPath.documentID(), in: documentIDs).getDocuments { response, error in
            guard ResponseHandler.responseHandler(error: error) else { self.didFinishRequest?()
                ; return }
            response?.documents.forEach({ data in
                var dictionary = data.data()
                dictionary["id"] = data.documentID
                objects.append(dictionary)
            })
            if isShowLoder {
                Helper.showLoader(isLoding: false)
            }
            if let lastDocument = response?.documents.last {
                completion(objects, lastDocument)
                self.didFinishRequest?()
                return
            }
            completion(objects, nil)
            self.didFinishRequest?()
        }
        return self
    }

    func fetchDocuments(limit: Int, lastDocument: QueryDocumentSnapshot?, isShowLoder: Bool = true, completion: @escaping ((_ objects: [[String: Any]], _ lastDocument: QueryDocumentSnapshot?) -> Void)) -> Self {
        guard Reachability.shared.isConnected(isShowMessage: false) else {
            DispatchQueue.main.async {
                self.offlineLoad?()
            }
            return self
        }
        if isShowLoder {
            Helper.showLoader(isLoding: true)
        }
        var objects: [[String: Any]] = []
        var query: Query? = reference?.limit(to: limit)
        if let lastDocument {
            query = query?.start(afterDocument: lastDocument)
        }
        query?.getDocuments { response, error in
            guard ResponseHandler.responseHandler(error: error) else { self.didFinishRequest?()
                ; return }
            response?.documents.forEach({ data in
                var dictionary = data.data()
                dictionary["id"] = data.documentID
                objects.append(dictionary)
            })
            if isShowLoder {
                Helper.showLoader(isLoding: false)
            }
            if let lastDocument = response?.documents.last {
                completion(objects, lastDocument)
                self.didFinishRequest?()
                return
            }
            completion(objects, nil)
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
