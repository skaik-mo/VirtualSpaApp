//
//  Post.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 25/07/2023.
//

import Foundation

class Post {
    var id: String?
    var description: String?
    var image: String?
    var userID: String?
    var userName: String?
    var userImage: String?
    var createdAt: Date?
    var modifiedAt: Date?
    var isFavorite: Bool = false

    init(description: String?, user: UserModel?) {
        self.id = UUID().uuidString
        self.description = description
        self.userID = user?.id
        self.userName = user?.name
        self.userImage = user?.image
        self.createdAt = Date()
        self.modifiedAt = Date()
        self.isFavorite = false
    }

    init?(dictionary: [String: Any]?) {
        guard let dictionary, !dictionary.isEmpty else { return nil }
        self.id = dictionary["id"] as? String
        self.description = dictionary["description"] as? String
        self.image = dictionary["image"] as? String
        self.userID = dictionary["userID"] as? String
        self.userName = dictionary["userName"] as? String
        self.userImage = dictionary["userImage"] as? String
        self.createdAt = (dictionary["createdAt"] as? String)?._dateWithFormate(dataFormat: GlobalConstants.dateAndTimeFormat)
        self.modifiedAt = (dictionary["modifiedAt"] as? String)?._dateWithFormate(dataFormat: GlobalConstants.dateAndTimeFormat)
        self.isFavorite = UserController().fetchUser()?.favoritePosts.contains(self.id ?? "") ?? false
    }

    func getDictionary() -> [String: Any] {
        let dictionary: [String: Any?] = [
//            "id": self.id,
            "description": self.description,
            "image": self.image,
            "userID": self.userID,
            "userName": self.userName,
            "userImage": self.userImage,
            "createdAt": self.createdAt?._string(dataFormat: GlobalConstants.dateAndTimeFormat),
            "modifiedAt": self.modifiedAt?._string(dataFormat: GlobalConstants.dateAndTimeFormat)
        ]
        return dictionary as [String: Any]
    }

    static func > (next: Post, previous: Post) -> Bool {
        if let createdPrevious = previous.modifiedAt, let createdNext = next.modifiedAt {
            return createdNext > createdPrevious
        }
        return false
    }
}
