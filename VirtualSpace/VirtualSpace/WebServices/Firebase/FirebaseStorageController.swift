//
//  FirebaseStorageController.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 19/07/2023.
//

import Foundation
import FirebaseStorage

class FirebaseStorageController: HandlerFinish {
    private let storage = Storage.storage()
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

    func uploadFile(data: Data?, path: String, handler: @escaping ((_ url: URL?) -> Void)) -> Self {
        guard let data else {
            handler(nil)
            return self
        }
        let reference = storage.reference().child(path)
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        let uploadTask = reference.putData(data, metadata: metadata) { _, error in
            guard ResponseHandler.responseHandler(error: error, isShowMessage: true) else {
                DispatchQueue.main.async {
                    self.didFinishRequest?()
                }
                return
            }
            reference.downloadURL { (url, error) in
                guard ResponseHandler.responseHandler(error: error, isShowMessage: true) else {
                    DispatchQueue.main.async {
                        self.didFinishRequest?()
                    }
                    return
                }
                guard let downloadURL = url else {
                    DispatchQueue.main.async {
                        self.didFinishRequest?()
                    }
                    return
                }
                debugPrint("File is uploaded.")
                debugPrint(downloadURL)
                handler(downloadURL)
            }
        }
        _ = uploadTask.observe(.progress, handler: { snapshot in
            let progress = Float(Float((snapshot.progress?.completedUnitCount ?? 0)) / Float(snapshot.progress?.totalUnitCount ?? 0))
            debugPrint(progress)
            Helper.showLoader(isLoding: true, progress: progress)
        })
        return self
    }
}
