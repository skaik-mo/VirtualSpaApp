//
//  FriendController.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 01/08/2023.
//

import FirebaseFirestore

class FriendController {
    private let referance: FirebaseFirestoreController = FirebaseFirestoreController().setFirebaseReference(.Friend)

    private func setFriends(_ objects: [Any]) -> [Friend] {
        var friends: [Friend] = []
        objects.forEach { object in
            if let friend = Friend.init(dictionary: object as? [String: Any]) {
                friends.append(friend)
            }
        }
        return friends
    }

    func addFriend(friend: Friend, success: @escaping () -> Void) -> FirebaseFirestoreController {
        guard let friendID = friend.id else { return referance }
        return referance.setData(document: friendID, dictionary: friend.getDictionaryforDatabase(), success: success)
    }

    func deleteFriend(friendID: String, isShowLoader: Bool = false, success: @escaping () -> Void) -> FirebaseFirestoreController {
        return referance.deleteDocument(documentID: friendID, isShowLoader: isShowLoader, success: success)
    }

    func checkFriend(otherUserID: String?, completion: @escaping (_ friend: Friend?) -> Void) -> FirebaseFirestoreController {
        guard let id = UserController().fetchUser()?.id, let otherUserID else { return referance }
        let query = referance.reference?.whereField("userIDs", arrayContains: id)
        return referance.fetchDocuments(query: query, lastDocument: nil, isShowLoader: true) { objects, _ in
            let friend = self.setFriends(objects).first(where: { $0.userIDs.contains(otherUserID) })
            completion(friend)
        }
    }

    func getFriends(limit: Int?, lastDocument: QueryDocumentSnapshot?, isShowLoader: Bool, handlerResponse: @escaping ((_ objects: [Friend], _ lastDocuments: QueryDocumentSnapshot?, _ headerObject: Any?) -> Void)) -> FirebaseFirestoreController {
        guard let id = UserController().fetchUser()?.id else { return referance }
        var query = referance.reference?.order(by: "createdAt", descending: true).whereField("userIDs", arrayContains: id)
        if let limit {
            query = query?.limit(to: limit)
        }
        return referance.fetchDocuments(query: query, lastDocument: lastDocument, isShowLoader: isShowLoader) { objects, lastDocument in
            guard let lastDocument = lastDocument else { handlerResponse([], nil, nil); return }
            let friends = self.setFriends(objects)
            handlerResponse(friends, lastDocument, nil)
        }
    }

}
