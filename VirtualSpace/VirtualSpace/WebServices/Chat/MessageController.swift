//
//  MessageController.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 27/07/2023.
//

import FirebaseFirestore

class MessageController {

    private let referance: FirebaseFirestoreController = FirebaseFirestoreController().setFirebaseReference(.Message)

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
        return referance.setData(document: message.messageId, dictionary: message.getDictionary(), isShowLoader: false, success: success)
    }

    // MARK: - Text Fetch
    func getMessages(conversationID: String, handlerResponse: @escaping ((_ messages: [Message]) -> Void)) -> FirebaseFirestoreController {
        let query = referance.reference?.whereField("conversationID", isEqualTo: conversationID)
        return referance.fetchDocumentsWithListener(query: query, lastDocument: nil, isShowLoader: true) { objects, _ in
            let messages = self.setMessages(objects)
            handlerResponse(messages)
        }
    }

    func removeListener() {
        referance.removeListener()
    }

    func deleteMessages(conversationID: String) {
        let query = referance.reference?.whereField("conversationID", isEqualTo: conversationID)
        _ = referance.fetchDocuments(query: query, lastDocument: nil, isShowLoader: false) { objects, _ in
            let messages = self.setMessages(objects)
            messages.forEach { message in
                _ = self.referance.deleteDocument(documentID: message.messageId, isShowLoader: false) { }
            }
        }
    }

}
