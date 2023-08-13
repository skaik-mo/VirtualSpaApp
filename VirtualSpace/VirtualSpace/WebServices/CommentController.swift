//
//  CommentController.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 26/07/2023.
//

import FirebaseFirestore

class CommentController {
    private let referance: FirebaseFirestoreController = FirebaseFirestoreController().setFirebaseReference(.Comment)

    private func setComments(_ objects: [Any]) -> [Comment] {
        var comments: [Comment] = []
        objects.forEach { object in
            if let comment = Comment.init(dictionary: object as? [String: Any]) {
                comments.append(comment)
            }
        }
        return comments
    }

    func setComment(comment: Comment) -> FirebaseFirestoreController {
        return self.referance.setData(dictionary: comment.getDictionary(), isShowLoader: false, success: { })
    }

    private func getComments(query: Query?, post: Post, lastDocument: QueryDocumentSnapshot?, isShowLoader: Bool, handlerResponse: @escaping ((_ objects: [Comment], _ lastDocuments: QueryDocumentSnapshot?, _ headerObject: Any?) -> Void)) -> FirebaseFirestoreController? {
        return referance.fetchDocuments(query: query, lastDocument: lastDocument, isShowLoader: isShowLoader) { objects, lastDocument in
            guard let lastDocument = lastDocument else { handlerResponse([], nil, post); return }
            let comments = self.setComments(objects)
            handlerResponse(comments, lastDocument, post)
        }
    }

    private func getCommentsForPost(post: Post, isShowLoader: Bool, handlerResponse: @escaping ((_ objects: [Comment], _ lastDocuments: QueryDocumentSnapshot?, _ headerObject: Any?) -> Void)) -> FirebaseFirestoreController? {
        guard let postID = post.id else { return referance }
        let query = referance.reference?.order(by: "createdAt", descending: true).whereField("postID", isEqualTo: postID)
        return self.getComments(query: query, post: post, lastDocument: nil, isShowLoader: isShowLoader, handlerResponse: handlerResponse)
    }

    func getCommentsForPostWithLimits(post: Post, lastDocument: QueryDocumentSnapshot?, isShowLoader: Bool, handlerResponse: @escaping ((_ objects: [Comment], _ lastDocuments: QueryDocumentSnapshot?, _ headerObject: Any?) -> Void)) -> FirebaseFirestoreController? {
        guard let id = post.id else { return referance }
        let query = referance.reference?.order(by: "createdAt", descending: true).whereField("postID", isEqualTo: id).limit(to: 10)
        return self.getComments(query: query, post: post, lastDocument: lastDocument, isShowLoader: isShowLoader, handlerResponse: handlerResponse)
    }

    private func deleteComment(id: String) {
        _ = referance.deleteDocument(documentID: id, success: { })
    }

    func deleteCommentsForPost(post: Post) {
        _ = self.getCommentsForPost(post: post, isShowLoader: false) { objects, _, _ in
            objects.forEach { comment in
                if let id = comment.id {
                    self.deleteComment(id: id)
                }
            }
        }
    }

}
