//
//  Conversation.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 27/07/2023.
//

import Foundation

class Conversation {
    var id: String?
    var userIDs: [String] = []
    var lastMessage: String?
    var sentDate: Date?
    var users: [UserModel] = []

    init(id: String?) {
        self.id = id
    }

    init(id: String? = UUID().uuidString, userIDs: [String], users: [UserModel], lastMessage: String?) {
        self.id = id
        self.userIDs = userIDs
        self.lastMessage = lastMessage
        self.sentDate = Date()
        self.users = users
    }

    init?(dictionary: [String: Any]?) {
        guard let dictionary, !dictionary.isEmpty else { return nil }
        self.id = dictionary["id"] as? String
        self.userIDs = dictionary["userIDs"] as? [String] ?? []
        self.lastMessage = dictionary["lastMessage"] as? String
        let users = dictionary["users"] as? [[String: Any]] ?? []
        users.forEach { user in
            if let _user = UserModel(dictionary: user) {
                self.users.append(_user)
            }
        }
        if let timestamp = dictionary["timestamp"] as? Double {
            self.sentDate = Date.init(timeIntervalSince1970: timestamp)
        }
    }

    func getDictionary() -> [String: Any] {
        let dictionary: [String: Any?] = [
//            "id": self.id,
            "userIDs": self.userIDs,
            "users": self.users.map({ $0.getDictionary() }),
            "lastMessage": self.lastMessage,
            "timestamp": self.sentDate?.timeIntervalSince1970
        ]
        return dictionary as [String: Any]
    }

    static func > (next: Conversation, previous: Conversation) -> Bool {
        if let createdPrevious = previous.sentDate, let createdNext = next.sentDate {
            return createdNext > createdPrevious
        }
        return false
    }

}
