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
    var user: UserModel?
    var createdAt: Date?
    var modifiedAt: Date?
    var isFavorite: Bool = false

    init(description: String?, user: UserModel?) {
        self.id = UUID().uuidString
        self.description = description
        self.user = user
        self.createdAt = Date()
        self.modifiedAt = Date()
        self.isFavorite = false
    }

    init?(dictionary: [String: Any]?) {
        guard let dictionary, !dictionary.isEmpty else { return nil }
        self.id = dictionary["id"] as? String
        self.description = dictionary["description"] as? String
        self.image = dictionary["image"] as? String
        self.user = UserModel(dictionary: dictionary["user"] as? [String: Any])
        self.createdAt = (dictionary["createdAt"] as? String)?._dateWithFormate(dataFormat: GlobalConstants.dateAndTimeFormat)
        self.modifiedAt = (dictionary["modifiedAt"] as? String)?._dateWithFormate(dataFormat: GlobalConstants.dateAndTimeFormat)
        self.isFavorite = UserController().fetchUser()?.favoritePosts.contains(self.id ?? "") ?? false
    }

    func getDictionary() -> [String: Any] {
        var dictionary: [String: Any?] = [
//            "id": self.id,
            "description": self.description,
            "image": self.image,
            "user": self.user?.getDictionaryForPost(),
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
