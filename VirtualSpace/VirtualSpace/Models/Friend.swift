//
//  Friend.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 01/08/2023.
//

import Foundation

class Friend {
    var id: String?
    var userIDs: [String] = []
    var users: [UserModel] = []
    var createdAt: Date?

    init(id: String? = UUID().uuidString, userIDs: [String], users: [UserModel]) {
        self.id = id
        self.userIDs = userIDs
        self.users = users
        self.createdAt = Date()
    }

    init?(dictionary: [String: Any]?) {
        guard let dictionary, !dictionary.isEmpty else { return nil }
        self.id = dictionary["id"] as? String
        self.userIDs = dictionary["userIDs"] as? [String] ?? []
        let users = dictionary["users"] as? [[String: Any]] ?? []
        users.forEach { user in
            if let _user = UserModel(dictionary: user) {
                self.users.append(_user)
            }
        }
        self.createdAt = (dictionary["createdAt"] as? String)?._dateWithFormate(dataFormat: GlobalConstants.dateAndTimeFormat)
    }

    func getDictionary() -> [String: Any] {
        let dictionary: [String: Any?] = [
            "id": self.id,
            "userIDs": self.userIDs,
            "users": self.users.map({ $0.getDictionary() }),
            "createdAt": self.createdAt?._string(dataFormat: GlobalConstants.dateAndTimeFormat)
        ]
        return dictionary as [String: Any]
    }

    func getDictionaryforDatabase() -> [String: Any] {
        let dictionary: [String: Any?] = [
            "userIDs": self.userIDs,
            "users": self.users.map({ $0.getDictionary() }),
            "createdAt": self.createdAt?._string(dataFormat: GlobalConstants.dateAndTimeFormat)
        ]
        return dictionary as [String: Any]
    }
}
