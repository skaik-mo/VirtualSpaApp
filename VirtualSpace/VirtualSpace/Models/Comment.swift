//
//  Comment.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 26/07/2023.
//

import Foundation

class Comment {
    var id: String?
    var postID: String?
    var userID: String?
    var userImage: String?
    var description: String?
    var createdAt: Date?

    init(id: String? = nil, postID: String? = nil, userID: String? = nil, userImage: String? = nil, description: String? = nil) {
        self.id = id
        self.postID = postID
        self.userID = userID
        self.userImage = userImage
        self.description = description
        self.createdAt = Date()
    }

    init?(dictionary: [String: Any]?) {
        guard let dictionary, !dictionary.isEmpty else { return nil }
        self.id = dictionary["id"] as? String
        self.postID = dictionary["postID"] as? String
        self.userID = dictionary["userID"] as? String
        self.userImage = dictionary["userImage"] as? String
        self.description = dictionary["description"] as? String
        self.createdAt = (dictionary["createdAt"] as? String)?._dateWithFormate(dataFormat: GlobalConstants.dateAndTimeFormat)
    }

    func getDictionary() -> [String: Any] {
        let dictionary: [String: Any?] = [
//            "id": self.id,
            "postID": self.postID,
            "userID": self.userID,
            "userImage": self.userImage,
            "description": self.description,
            "createdAt": self.createdAt?._string(dataFormat: GlobalConstants.dateAndTimeFormat)
        ]
        return dictionary as [String: Any]
    }
}
