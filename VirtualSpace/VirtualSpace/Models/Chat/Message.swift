//
//  Message.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 16/07/2023.
//

import Foundation
import MessageKit
import UIKit

class Message: MessageType {
    var sender: SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKind
    var toId: String

    init(sender: Sender, messageId: String, sentDate: Date, kind: MessageKit.MessageKind, toId: String) {
        self.sender = sender
        self.messageId = messageId
        self.sentDate = sentDate
        self.kind = kind
        self.toId = toId
    }

//    init?(dictionary: [String: Any]?) {
//        if let dictionary = dictionary, !dictionary.isEmpty, let userID = dictionary["fromId"] as? String, let messageId = dictionary["id"] as? String, let timestamp = dictionary["timestamp"] as? Double, let toId = dictionary["toId"] as? String {
//
//            self.sender = Sender.init(senderId: userID)
//            self.messageId = messageId
//            self.sentDate = Date.init(timeIntervalSince1970: timestamp)
//            self.seen = dictionary["seen"] as? Bool ?? false
//            self.toId = toId
//            if let text = dictionary["text"] as? String {
//                self.kind = .text(text)
//
//            } else if let image = dictionary["image"] as? String, let imageUrl = URL(string: image), let placeholder = UIImage.ic_placeholder {
//                self.kind = .photo(Media(url: imageUrl, placeholderImage: placeholder))
//            } else {
//                self.kind = .text("")
//            }
//        } else {
//            return nil
//        }
//
//    }

//    func getDictionary() -> [String: Any] {
//        var dictionary: [String: Any?] = [
//            "fromId": self.sender.senderId,
//            "id": self.messageId,
//            "seen": self.seen,
//            "timestamp": self.sentDate.timeIntervalSince1970,
//            "toId": self.toId,
//            "text": nil,
//            "image": nil,
//        ]
//        switch self.kind {
//
//        case .text(let text):
//            dictionary["text"] = text
//        case .photo(let media):
//            dictionary["image"] = media.url?.absoluteString
//        default:
//            break
//        }
//        return dictionary as [String: Any]
//    }
//
//    static func > (next: Message, previous: Message) -> Bool {
//        return previous.sentDate > next.sentDate
//    }

}
