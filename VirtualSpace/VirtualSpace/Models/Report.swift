//
//  Report.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 13/08/2023.
//

import Foundation

class Report {
    var id: String?
    var userID: String?
    var postID: String?
    var createdAt: Date?

    init(id: String? = nil, userID: String?, postID: String?) {
        self.id = id
        self.userID = userID
        self.postID = postID
        self.createdAt = Date()
    }

//    init?(dictionary: [String: Any]?) {
//        guard let dictionary, !dictionary.isEmpty else { return nil }
//        self.id = dictionary["id"] as? String
//        self.userID = dictionary["userID"] as? String
//        self.postID = dictionary["postID"] as? String
//        self.createdAt = Date.init(timeIntervalSince1970: (dictionary["createdAtø"] as? Double) ?? Date().timeIntervalSince1970)
//    }

    func getDictionary() -> [String: Any] {
        let dictionary: [String: Any?] = [
//            "id": self.id,
            "userID": self.userID,
            "postID": self.postID,
            "createdAt": self.createdAt?.timeIntervalSince1970
        ]
        return dictionary as [String: Any]
    }
}
