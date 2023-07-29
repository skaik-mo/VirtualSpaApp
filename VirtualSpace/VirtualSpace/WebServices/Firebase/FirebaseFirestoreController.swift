//
//  FirebaseFirestoreController.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 19/07/2023.
//

import Foundation
import FirebaseFirestore

class FirebaseFirestoreController: HandlerFinish {
    var reference: CollectionReference?
    var didFinishRequest: (() -> Void)?
    var offlineLoad: (() -> Void)?
    private static var listener: ListenerRegistration?

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
}

// MARK: - Add Or Update
extension FirebaseFirestoreController {
    func setData(document: String = UUID().uuidString, dictionary: [String: Any], isShowLoader: Bool = true, isShowMessage: Bool = true, success: @escaping () -> Void) -> Self {
        guard Reachability.shared.isConnected() else {
            DispatchQueue.main.async {
                self.offlineLoad?()
            }
            return self
        }
        if isShowLoader {
            Helper.showLoader(isLoding: true)
        }
        reference?.document(document).setData(dictionary, completion: { error in
            self.didFinishRequest?()
            guard ResponseHandler.responseHandler(error: error) else { return }
            success()
            if isShowLoader {
                Helper.showLoader(isLoding: false)
            }
        })
        return self
    }
}

// MARK: - Fetch
extension FirebaseFirestoreController {
    func fetchDocument(document: String, isShowLoader: Bool = true, success: @escaping (_ dictionary: [String: Any]?) -> Void) -> Self {
        guard Reachability.shared.isConnected() else {
            DispatchQueue.main.async {
                self.offlineLoad?()
            }
            return self
        }
        if isShowLoader {
            Helper.showLoader(isLoding: true)
        }
        reference?.document(document).getDocument { response, error in
            self.didFinishRequest?()
            guard ResponseHandler.responseHandler(error: error) else { return }
            let data = response?.data() as? [String: Any]
            success(data)
            if isShowLoader {
                Helper.showLoader(isLoding: false)
            }
        }
        return self
    }

    func fetchDocuments(isShowLoader: Bool, completion: @escaping ((_ objects: [[String: Any]]) -> Void)) -> Self {
        guard Reachability.shared.isConnected(isShowMessage: false) else {
            DispatchQueue.main.async {
                self.offlineLoad?()
            }
            return self
        }
        if isShowLoader {
            Helper.showLoader(isLoding: true)
        }
        var objects: [[String: Any]] = []
        reference?.getDocuments { response, error in
            guard ResponseHandler.responseHandler(error: error) else { self.didFinishRequest?()
                ; return }
            response?.documents.forEach({ data in
                var dictionary = data.data()
                dictionary["id"] = data.documentID
                objects.append(dictionary)
            })
            if isShowLoader {
                Helper.showLoader(isLoding: false)
            }
            completion(objects)
            self.didFinishRequest?()
        }
        return self
    }

    func fetchDocuments(query: Query?, lastDocument: QueryDocumentSnapshot?, isShowLoader: Bool, completion: @escaping ((_ objects: [[String: Any]], _ lastDocument: QueryDocumentSnapshot?) -> Void)) -> Self {
        guard Reachability.shared.isConnected(isShowMessage: false) else {
            DispatchQueue.main.async {
                self.offlineLoad?()
            }
            return self
        }
        if isShowLoader {
            Helper.showLoader(isLoding: true)
        }
        var objects: [[String: Any]] = []
        var query = query
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
            if isShowLoader {
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

}

// MARK: - Fetch With Listener
extension FirebaseFirestoreController {
    func fetchDocumentsWithListener(query: Query?, lastDocument: QueryDocumentSnapshot?, isShowLoader: Bool, completion: @escaping ((_ objects: [[String: Any]], _ lastDocument: QueryDocumentSnapshot?) -> Void)) -> Self {
        guard Reachability.shared.isConnected(isShowMessage: false) else {
            DispatchQueue.main.async {
                self.offlineLoad?()
            }
            return self
        }
        if isShowLoader {
            Helper.showLoader(isLoding: true)
        }
        var objects: [[String: Any]] = []
        var query = query
        if let lastDocument {
            query = query?.start(afterDocument: lastDocument)
        }
        Self.listener = query?.addSnapshotListener({ response, error in
            guard ResponseHandler.responseHandler(error: error) else { self.didFinishRequest?()
                ; return }
            objects.removeAll()
            response?.documents.forEach({ data in
                var dictionary = data.data()
                dictionary["id"] = data.documentID
                objects.append(dictionary)
            })
            if isShowLoader {
                Helper.showLoader(isLoding: false)
            }
            if let lastDocument = response?.documents.last {
                completion(objects, lastDocument)
                self.didFinishRequest?()
                return
            }
            completion(objects, nil)
            self.didFinishRequest?()
        })
        return self
    }

    func removeListener() {
        Self.listener?.remove()
        Self.listener = nil
    }
}

// MARK: - Delete
extension FirebaseFirestoreController {
    func deleteDocument(documentID: String, isShowLoader: Bool = true, isShowMessage: Bool = true, success: @escaping () -> Void) -> Self {
        guard Reachability.shared.isConnected() else {
            DispatchQueue.main.async {
                self.offlineLoad?()
            }
            return self
        }
        if isShowLoader {
            Helper.showLoader(isLoding: true)
        }
        reference?.document(documentID).delete(completion: { error in
            guard ResponseHandler.responseHandler(error: error) else { return }
            if isShowLoader {
                Helper.showLoader(isLoding: false)
            }
            success()
            self.didFinishRequest?()
        })
        return self
    }

}
