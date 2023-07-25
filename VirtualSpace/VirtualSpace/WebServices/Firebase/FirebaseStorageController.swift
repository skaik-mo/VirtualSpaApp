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
        guard Reachability.shared.isConnected() else {
            DispatchQueue.main.async {
                self.offlineLoad?()
                handler(nil)
            }
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

    func uploadFiles(data values: [String: Data?], handler: @escaping ((_ urls: [String: URL]) -> Void)) -> Self {
        guard !values.isEmpty else {
            handler([:])
            return self
        }
        var urls: [String: URL] = [:]
        var uploadCount = 0

        for data in values {
            if let value = data.value {
                let riversRef = storage.reference().child(data.key)
                let metadata = StorageMetadata()
                metadata.contentType = "image/jpeg"
                _ = riversRef.putData(value, metadata: metadata) { _, error in
                    guard ResponseHandler.responseHandler(error: error, isShowMessage: true) else {
                        DispatchQueue.main.async {
                            self.didFinishRequest?()
                        }
                        return
                    }
                    riversRef.downloadURL { (url, error) in
                        guard ResponseHandler.responseHandler(error: error, isShowMessage: true) else {
                            DispatchQueue.main.async {
                                self.didFinishRequest?()
                            }
                            return
                        }
                        guard let downloadURL = url else {
                            handler([:])
                            DispatchQueue.main.async {
                                self.didFinishRequest?()
                            }
                            return
                        }
                        urls[data.key] = downloadURL
                        uploadCount += 1
                        debugPrint("Number of images successfully uploaded: \(uploadCount)")
                        if uploadCount == values.count {
                            debugPrint("Image is uploaded successfully, uploadedImageUrlsArray: \(urls)")
                            handler(urls)
                        }
                    }
                }
            }
        }
        return self
    }
}

// MARK: - Delete File
extension FirebaseStorageController {

    func deleteFile(path: String, isShowLoder: Bool = true, success: @escaping () -> Void) {
        if isShowLoder {
            Helper.showLoader(isLoding: true)
        }
        storage.reference().child(path).delete { error in
            if let error = error as? NSError, StorageErrorCode.init(rawValue: (error).code) != .objectNotFound, ResponseHandler.responseHandler(error: error) { return }
            success()
            if isShowLoder {
                Helper.showLoader(isLoding: false)
            }
        }
    }
}
