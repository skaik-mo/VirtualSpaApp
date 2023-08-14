//
//  NotificationController.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 30/07/2023.
//

import FirebaseFirestore

class NotificationController {
    private let referance: FirebaseFirestoreController = FirebaseFirestoreController().setFirebaseReference(.Notification)

    private func setNotifications(_ objects: [Any]) -> [Notification] {
        var notifications: [Notification] = []
        objects.forEach { object in
            if let notification = Notification.init(dictionary: object as? [String: Any]) {
                notifications.append(notification)
            }
        }
        return notifications
    }

    func sendNotification(notification: Notification, isShowLoader: Bool) {
        _ = referance.setData(dictionary: notification.getDictionary(), isShowLoader: isShowLoader, success: { })
    }

    func getNotification(lastDocument: QueryDocumentSnapshot?, isShowLoader: Bool, handlerResponse: @escaping ((_ objects: [Any], _ lastDocuments: QueryDocumentSnapshot?, _ headerObject: Any?) -> Void)) -> FirebaseFirestoreController {
        guard let id = UserController().fetchUser()?.id else { return referance }
        let query = referance.reference?.order(by: "createdAt", descending: true).whereFilter(Filter .orFilter([Filter.whereField("type", isEqualTo: 0), Filter.whereField("recipient", isEqualTo: id)])).limit(to: 10)
        return referance.fetchDocuments(query: query, lastDocument: lastDocument, isShowLoader: isShowLoader) { objects, lastDocument in
            guard let lastDocument = lastDocument else { handlerResponse([], nil, nil); return }
            let notifications = self.setNotifications(objects)
            handlerResponse(notifications, lastDocument, nil)
            DispatchQueue.main.async {
                self.setReadNotification(readNotifications: notifications.filter({ $0.read == false }))
            }
        }
    }

    private func setReadNotification(readNotifications: [Notification]) {
        let _readNotifications = readNotifications
        _readNotifications.forEach { notification in
            if let id = notification.id {
                notification.read = true
                _ = referance.setData(document: id, dictionary: notification.getDictionary(), isShowLoader: false, success: { })
            }
        }
    }

}
