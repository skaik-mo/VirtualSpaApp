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
        friends = friends.sorted(by: >)
        return friends
    }

    func addFriend(friend: Friend, success: @escaping () -> Void) -> FirebaseFirestoreController {
        return referance.setData(dictionary: friend.getDictionaryforDatabase(), success: success)
    }

    func deleteFriend(friendID: String, success: @escaping () -> Void) -> FirebaseFirestoreController {
        return referance.deleteDocument(documentID: friendID, isShowLoader: false, success: success)
    }

    func checkFriend(otherUserID: String?, completion: @escaping (_ friend: Friend?) -> Void) -> FirebaseFirestoreController {
        guard let id = UserController().fetchUser()?.id, let otherUserID else { return referance }
        let query = referance.reference?.whereField("userIDs", arrayContainsAny: [otherUserID, id])
        return referance.fetchDocuments(query: query, lastDocument: nil, isShowLoader: true) { objects, _ in
            let friend = self.setFriends(objects).first
            completion(friend)
        }
    }

    func getFriends(limit: Int?, lastDocument: QueryDocumentSnapshot?, isShowLoader: Bool, handlerResponse: @escaping ((_ objects: [Friend], _ lastDocuments: QueryDocumentSnapshot?, _ headerObject: Any?) -> Void)) -> FirebaseFirestoreController {
        guard let id = UserController().fetchUser()?.id else { return referance }
//        Not working order
//        var query = referance.reference?.order(by: "createAt", descending: true).whereField("userIDs", arrayContains: id)
        var query = referance.reference?.whereField("userIDs", arrayContains: id)
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
