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
    var conversationID: String
    var sender: SenderType
    var messageId: String
    var sentDate: Date
    var kind: MessageKind

    init(conversationID: String, sender: Sender, messageId: String = UUID().uuidString, kind: MessageKit.MessageKind) {
        self.conversationID = conversationID
        self.sender = sender
        self.messageId = messageId
        self.sentDate = Date()
        self.kind = kind
    }

    init?(dictionary: [String: Any]?) {
        if let dictionary = dictionary, !dictionary.isEmpty,
            let conversationID = dictionary["conversationID"] as? String,
            let senderID = dictionary["senderID"] as? String,
            let messageId = dictionary["id"] as? String,
            let timestamp = dictionary["timestamp"] as? Double {
            self.conversationID = conversationID
            self.sender = Sender.init(senderId: senderID)
            self.messageId = messageId
            self.sentDate = Date.init(timeIntervalSince1970: timestamp)
            if let text = dictionary["text"] as? String {
                self.kind = .text(text)

            } else {
                self.kind = .text("")
            }
        } else {
            return nil
        }
    }

    func getDictionary() -> [String: Any] {
        var dictionary: [String: Any?] = [
//            "id": self.messageId,
            "conversationID": self.conversationID,
            "senderID": self.sender.senderId,
            "timestamp": self.sentDate.timeIntervalSince1970
        ]
        switch self.kind {
        case .text(let text):
            dictionary["text"] = text
        default:
            break
        }
        return dictionary as [String: Any]
    }

    static func > (next: Message, previous: Message) -> Bool {
        return previous.sentDate > next.sentDate
    }

}
