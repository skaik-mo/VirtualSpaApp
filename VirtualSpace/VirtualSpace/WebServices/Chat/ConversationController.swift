//
//  ConversationController.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 27/07/2023.
//

import FirebaseFirestore

class ConversationController {

    private let referance: FirebaseFirestoreController = FirebaseFirestoreController().setFirebaseReference(.Conversation)
    static var listener: ListenerRegistration?

    private func setConversations(_ objects: [Any]) -> [Conversation] {
        var conversations: [Conversation] = []
        objects.forEach { object in
            if let conversation = Conversation.init(dictionary: object as? [String: Any]) {
                conversations.append(conversation)
            }
        }
        conversations = conversations.sorted(by: >)
        return conversations
    }

    func getConversations(isShowLoader: Bool, handlerResponse: @escaping ((_ objects: [Any], _ headerObject: Any?) -> Void)) -> FirebaseFirestoreController {
        guard let userID = UserController().fetchUser()?.id else { fatalError("\(#function) The user id is nil") }
        Self.listener = referance.fetchDocumentsWithListener(query: referance.reference?.whereField("userIDs", arrayContains: userID)) { objects in
            let conversations = self.setConversations(objects)
            handlerResponse(conversations, nil)
        }
        return referance
    }

    func getConversation(otherUser: UserModel, isShowLoader: Bool, handlerResponse: @escaping ((_ conversation: Conversation) -> Void)) -> FirebaseFirestoreController {
        guard let auth = UserController().fetchUser(), let authID = auth.id,
            let otherUserID = otherUser.id else { fatalError("\(#function) The user id is nil") }
        _ = referance.fetchDocumentsWithFields(query: referance.reference?.whereField("userIDs", arrayContainsAny: [authID, otherUserID])) { objects in
            let conversations = self.setConversations(objects)
            if let conversation = conversations.first {
                handlerResponse(conversation)
            } else {
                let conversation = Conversation(userIDs: [authID, otherUserID], users: [auth, otherUser], lastMessage: nil)
                handlerResponse(conversation)
            }
        }
        return referance
    }

    func addConversation(conversation: Conversation, success: @escaping () -> Void) -> FirebaseFirestoreController {
        guard let id = conversation.id else { return referance }
        return referance.setData(document: id, dictionary: conversation.getDictionary(), isShowLoder: false, success: success)
    }

    func removeListener() {
        Self.listener?.remove()
    }

    func deleteConversation(conversation: Conversation) {
        guard let id = conversation.id else { return }
        _ = referance.deleteDocument(documentID: id, isShowLoder: false) {
            MessageController().deleteMessages(conversationID: id)
        }
    }

}
