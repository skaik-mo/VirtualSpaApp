//
//  MessageController.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 27/07/2023.
//

import FirebaseFirestore

class MessageController {

    private let referance: FirebaseFirestoreController = FirebaseFirestoreController().setFirebaseReference(.Message)
    static var listener: ListenerRegistration?

    private func setMessages(_ objects: [Any]) -> [Message] {
        var messages: [Message] = []
        objects.forEach { object in
            if let message = Message.init(dictionary: object as? [String: Any]) {
                messages.append(message)
            }
        }
        messages = messages.sorted(by: >)
        return messages
    }

    func addMessage(message: Message, success: @escaping () -> Void) -> FirebaseFirestoreController {
        return referance.setData(document: message.messageId, dictionary: message.getDictionary(), isShowLoder: false, success: success)
    }

    func getMessages(conversationID: String, handlerResponse: @escaping ((_ messages: [Message]) -> Void)) -> FirebaseFirestoreController {
        Self.listener = referance.fetchDocumentsWithListener(query: referance.reference?.whereField("conversationID", isEqualTo: conversationID)) { objects in
            let messages = self.setMessages(objects)
            handlerResponse(messages)
        }
        return referance
    }

    func removeListener() {
        Self.listener?.remove()
    }

    func deleteMessages(conversationID: String) {
        _ = referance.getDocuments(query: referance.reference?.whereField("conversationID", isEqualTo: conversationID), isShowLoder: false) { objects in
            let messages = self.setMessages(objects)
            messages.forEach { message in
                _ = self.referance.deleteDocument(documentID: message.messageId, isShowLoder: false) {}
            }
        }
    }

}
