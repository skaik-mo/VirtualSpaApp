//
//  Notification.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 30/07/2023.
//

import Foundation

class Notification {
    var id: String?
    var sender: String?
    var recipient: String?
    var type: GlobalConstants.NotificationType = .Alert
    var title: String?
    var body: String?
    var image: String?
    var createdAt: Date?
    var data: [String: Any]?

    init(sender: String?, recipient: String?, type: GlobalConstants.NotificationType, title: String?, body: String?, image: String?, data: [String: Any]?) {
        self.sender = sender
        self.recipient = recipient
        self.type = type
        self.title = title
        self.body = body
        self.image = image
        self.createdAt = Date()
        self.data = data
    }

    init?(dictionary: [String: Any]?) {
        guard let dictionary = dictionary, !dictionary.isEmpty else { return nil }
        self.id = dictionary["id"] as? String
        self.sender = dictionary["sender"] as? String
        self.recipient = dictionary["recipient"] as? String
        self.type = GlobalConstants.NotificationType.getType(dictionary["type"] as? Int)
        self.title = dictionary["title"] as? String
        self.body = dictionary["body"] as? String
        self.image = dictionary["image"] as? String
        self.createdAt = Date.init(timeIntervalSince1970: (dictionary["createdAt"] as? Double) ?? Date().timeIntervalSince1970)
        self.data = dictionary["data"] as? [String: Any]
    }

    func getDictionary() -> [String: Any] {
        let dictionary: [String: Any?] = [
//            "id": self.id,
            "sender": self.sender,
            "recipient": self.recipient,
            "type": self.type.rawValue,
            "title": self.title,
            "body": self.body,
            "image": self.image,
            "createdAt": self.createdAt?.timeIntervalSince1970,
            "data": self.data
        ]
        return dictionary as [String: Any]
    }

    static func > (next: Notification, previous: Notification) -> Bool {
        if let createdPrevious = previous.createdAt, let createdNext = next.createdAt {
            return createdNext > createdPrevious
        }
        return false
    }

}
