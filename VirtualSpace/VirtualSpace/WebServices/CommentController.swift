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
        comments = comments.sorted(by: >)
        return comments
    }

    func setComment(comment: Comment) -> FirebaseFirestoreController {
        return self.referance.setData(dictionary: comment.getDictionary(), isShowLoder: false, success: { })
    }

    func getCommentsForPost(post: Post, lastDocument: QueryDocumentSnapshot?, isShowLoader: Bool, handlerResponse: @escaping ((_ objects: [Any], _ lastDocuments: QueryDocumentSnapshot?, _ headerObject: Any?) -> Void)) -> FirebaseFirestoreController? {
        guard let id = post.id else { return referance }
        return referance.fetchDocumentsWithField(field: "postID", value: id, limit: 10, lastDocument: lastDocument, isShowLoder: isShowLoader) { objects, lastDocument in
            guard let lastDocument = lastDocument else { handlerResponse([], nil, post); return }
            let comments = self.setComments(objects)
            handlerResponse(comments, lastDocument, post)
        }
    }
}
