//
//  FollowController.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 26/07/2023.
//

import FirebaseFirestore

class FollowController {
    private let referance: FirebaseFirestoreController = FirebaseFirestoreController().setFirebaseReference(.Follow)

    private func setFollows(_ objects: [Any]) -> [Follow] {
        var follows: [Follow] = []
        objects.forEach { object in
            if let follow = Follow.init(dictionary: object as? [String: Any]) {
                follows.append(follow)
            }
        }
        follows = follows.sorted(by: >)
        return follows
    }

    private func getFollows(field: String, value: Any, lastDocument: QueryDocumentSnapshot?, isShowLoader: Bool, handlerResponse: @escaping ((_ objects: [Follow], _ lastDocuments: QueryDocumentSnapshot?, _ headerObject: Any?) -> Void)) -> FirebaseFirestoreController {
        let query = referance.reference?.limit(to: 10).whereField(field, isEqualTo: value)
        return referance.fetchDocuments(query: query, lastDocument: lastDocument, isShowLoader: isShowLoader) { objects, lastDocument in
            guard let lastDocument = lastDocument else { handlerResponse([], nil, nil); return }
            let following = self.setFollows(objects)
            handlerResponse(following, lastDocument, nil)
        }
    }

    // MARK: - Get Following for UserType == Business
    func getFollowing(lastDocument: QueryDocumentSnapshot?, isShowLoader: Bool, handlerResponse: @escaping ((_ objects: [Any], _ lastDocuments: QueryDocumentSnapshot?, _ headerObject: Any?) -> Void)) -> FirebaseFirestoreController {
        guard let followingUser = UserController().fetchUser(), followingUser.type == .Business, let followingUserID = followingUser.id else { fatalError("\(#function) The user id is nil") }
        return self.getFollows(field: "followingUserID", value: followingUserID, lastDocument: lastDocument, isShowLoader: isShowLoader) { objects, lastDocument, headerObject in
            guard !objects.isEmpty else { handlerResponse(objects, nil, nil); return}
            let followerUserIDs: [String] = objects.map { follow in
                return follow.followerUserID ?? ""
            }
            handlerResponse(objects, nil, nil)
            _ = UserController().getUsersWithIDs(userIDs: followerUserIDs, isShowLoader: isShowLoader) { users in
                objects.forEach { follow in
                    follow.user = users.first(where: { $0.id == follow.followerUserID })
                }
                handlerResponse(objects, lastDocument, headerObject)
            }
        }
    }

    // MARK: - Get Followers for UserType == User
    func getFollowers(lastDocument: QueryDocumentSnapshot?, isShowLoader: Bool, handlerResponse: @escaping ((_ objects: [Any], _ lastDocuments: QueryDocumentSnapshot?, _ headerObject: Any?) -> Void)) -> FirebaseFirestoreController {
        guard let followerUser = UserController().fetchUser(), followerUser.type == .User, let followerUserID = followerUser.id else { fatalError("\(#function) The user id is nil") }
        return self.getFollows(field: "followerUserID", value: followerUserID, lastDocument: lastDocument, isShowLoader: isShowLoader) { objects, lastDocument, headerObject in
            guard !objects.isEmpty else { handlerResponse(objects, nil, nil); return}
            let followingUserIDs: [String] = objects.map { follow in
                return follow.followingUserID ?? ""
            }
            handlerResponse(objects, nil, nil)
            _ = UserController().getUsersWithIDs(userIDs: followingUserIDs, isShowLoader: isShowLoader) { users in
                objects.forEach { follow in
                    follow.user = users.first(where: { $0.id == follow.followingUserID })
                }
                handlerResponse(objects, lastDocument, headerObject)
            }
        }
    }

    // MARK: - add Following for UserType == User
    func addFollowing(follow: Follow, success: @escaping () -> Void) -> FirebaseFirestoreController {
        guard let id = follow.id else { return referance }
        return referance.setData(document: id, dictionary: follow.getDictionary(), success: success)
    }

    // MARK: - remove Following for UserType == User
    func removeFollowing(followID: String, success: @escaping () -> Void) -> FirebaseFirestoreController {
        guard let followerUser = UserController().fetchUser(), followerUser.type == .User else { return referance }
        return referance.deleteDocument(documentID: followID, success: success)
    }

    // MARK: - search Following for UserType == User
    func searchFollowing(followerUserID: String, followingUserID: String, isShowLoader: Bool, handlerResponse: @escaping ((_ object: Follow?) -> Void)) -> FirebaseFirestoreController {
        let query = referance.reference?.whereField("followerUserID", isEqualTo: followerUserID).whereField("followingUserID", isEqualTo: followingUserID)
        return referance.fetchDocuments(query: query, lastDocument: nil, isShowLoader: isShowLoader) { objects, _ in
            if let follow = Follow.init(dictionary: objects.first) {
                handlerResponse(follow)
            } else {
                handlerResponse(nil)
            }
        }
    }
}
