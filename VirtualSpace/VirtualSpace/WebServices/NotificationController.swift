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
        notifications = notifications.sorted(by: >)
        return notifications
    }

    func sendNotification(notification: Notification, isShowLoader: Bool) {
        _ = referance.setData(dictionary: notification.getDictionary(), isShowLoader: isShowLoader, success: { })
    }

    func getNotification(lastDocument: QueryDocumentSnapshot?, isShowLoader: Bool, handlerResponse: @escaping ((_ objects: [Any], _ lastDocuments: QueryDocumentSnapshot?, _ headerObject: Any?) -> Void)) -> FirebaseFirestoreController {
        guard let id = UserController().fetchUser()?.id else { return referance }
        //        Not working order
//        let query = referance.reference?.order(by: "createdAt", descending: true).limit(to: 10).whereFilter(Filter.orFilter([Filter.whereField("type", isEqualTo: 0), Filter.whereField("recipient", isEqualTo: id)]))
        let query = referance.reference?.limit(to: 10).whereFilter(Filter.orFilter([Filter.whereField("type", isEqualTo: 0), Filter.whereField("recipient", isEqualTo: id)]))
        return referance.fetchDocuments(query: query, lastDocument: lastDocument, isShowLoader: isShowLoader) { objects, lastDocument in
            guard let lastDocument = lastDocument else { handlerResponse([], nil, nil); return }
            let notifications = self.setNotifications(objects)
            handlerResponse(notifications, lastDocument, nil)
        }

    }

}
