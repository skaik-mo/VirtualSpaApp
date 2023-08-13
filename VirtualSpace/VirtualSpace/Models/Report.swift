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
    var therapistID: String?
    var createdAt: Date?

    init(id: String? = nil, userID: String?, postID: String? = nil, therapistID: String? = nil) {
        self.id = id
        self.userID = userID
        self.postID = postID
        self.therapistID = therapistID
        self.createdAt = Date()
    }

    func getDictionaryPost() -> [String: Any] {
        let dictionary: [String: Any?] = [
            "userID": self.userID,
            "postID": self.postID,
            "createdAt": self.createdAt?.timeIntervalSince1970
        ]
        return dictionary as [String: Any]
    }

    func getDictionaryTherapist() -> [String: Any] {
        let dictionary: [String: Any?] = [
            "userID": self.userID,
            "therapistID": self.therapistID,
            "createdAt": self.createdAt?.timeIntervalSince1970
        ]
        return dictionary as [String: Any]
    }
}
