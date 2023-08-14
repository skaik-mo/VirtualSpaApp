//
//  Follow.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 26/07/2023.
//

import Foundation

class Follow {
    var id: String?
    var followerUserID: String? // The followerUserID var represents the user who is following someone "UserType == User"
    var followingUserID: String? // The followingUserID var represents the user who is being followed "UserType == Business"
    var createdAt: Date?
    var user: UserModel?

    init(id: String? = UUID().uuidString, followerUserID: String?, followingUserID: String?) {
        self.id = id
        self.followerUserID = followerUserID
        self.followingUserID = followingUserID
        self.createdAt = Date()
    }

    init?(dictionary: [String: Any]?) {
        guard let dictionary, !dictionary.isEmpty else { return nil }
        self.id = dictionary["id"] as? String
        self.followerUserID = dictionary["followerUserID"] as? String
        self.followingUserID = dictionary["followingUserID"] as? String
        self.createdAt = Date.init(timeIntervalSince1970: (dictionary["createdAt"] as? Double) ?? Date().timeIntervalSince1970)
    }

    func getDictionary() -> [String: Any] {
        let dictionary: [String: Any?] = [
            "followerUserID": self.followerUserID,
            "followingUserID": self.followingUserID,
            "createdAt": self.createdAt?.timeIntervalSince1970
        ]
        return dictionary as [String: Any]
    }

    static func > (next: Follow, previous: Follow) -> Bool {
        if let createdPrevious = previous.createdAt, let createdNext = next.createdAt {
            return createdNext > createdPrevious
        }
        return false
    }

}
