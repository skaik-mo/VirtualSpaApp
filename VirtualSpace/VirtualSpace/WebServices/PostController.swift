//
//  PostController.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 25/07/2023.
//

import FirebaseFirestore

class PostController {
    private let referance: FirebaseFirestoreController = FirebaseFirestoreController().setFirebaseReference(.Post)

    private func setPosts(_ objects: [Any]) -> [Post] {
        var posts: [Post] = []
        objects.forEach { object in
            if let post = Post.init(dictionary: object as? [String: Any]) {
                posts.append(post)
            }
        }
        return posts
    }

    func getPosts(lastDocument: QueryDocumentSnapshot?, isShowLoader: Bool, handlerResponse: @escaping ((_ objects: [Any], _ lastDocuments: QueryDocumentSnapshot?, _ headerObject: Any?) -> Void)) -> FirebaseFirestoreController? {
        let query = referance.reference?.order(by: "modifiedAt", descending: true).limit(to: 10)
        return referance.fetchDocuments(query: query, lastDocument: lastDocument, isShowLoader: isShowLoader) { objects, lastDocument in
            guard let lastDocument = lastDocument else { handlerResponse([], nil, nil); return }
            let posts = self.setPosts(objects)
            handlerResponse(posts, lastDocument, nil)
        }
    }

    func getPostsByUser(user: UserModel, lastDocument: QueryDocumentSnapshot?, isShowLoader: Bool, handlerResponse: @escaping ((_ objects: [Any], _ lastDocuments: QueryDocumentSnapshot?, _ headerObject: Any?) -> Void)) -> FirebaseFirestoreController? {
        guard let id = user.id else { return referance }
        let query = referance.reference?.order(by: "modifiedAt", descending: true).limit(to: 10).whereField("userID", isEqualTo: id)
        return referance.fetchDocuments(query: query, lastDocument: lastDocument, isShowLoader: isShowLoader) { objects, lastDocument in
            guard let lastDocument = lastDocument else { handlerResponse([], nil, user); return }
            let posts = self.setPosts(objects)
            handlerResponse(posts, lastDocument, user)
        }
    }

    func addPost(post: Post, image: UIImage?, success: @escaping (_ post: Post) -> Void) -> FirebaseStorageController {
        guard let id = post.id, let data = image?.jpegData(compressionQuality: 0.8) else { fatalError("\(#function) The post id and image are nil") }
        let path = "Posts/\(id).jpeg"
        return FirebaseStorageController().uploadFile(data: data, path: path) { url in
            if let image = url?.absoluteString {
                post.image = image
                _ = self.referance.setData(document: id, dictionary: post.getDictionary(), success: {
                        success(post)
                    })
            }
        }
    }

    func addFivoraitePost(post: Post) {
        guard let postID = post.id, let user = UserController().fetchUser() else { return }
        if let index = user.favoritePosts.firstIndex(of: postID) {
            user.favoritePosts.remove(at: index)
        } else {
            user.favoritePosts.append(postID)
        }
        UserController().setUser(user: user)
    }

}

// MARK: - Option
extension PostController {

    private func deletePost(post: Post, success: @escaping () -> Void) {
        guard let documentID = post.id else { return }
        _ = referance.deleteDocument(documentID: documentID, isShowLoader: false, success: {
            success()
            let path = "Posts/\(documentID).jpeg"
            FirebaseStorageController().deleteFile(path: path, isShowLoader: false, success: { })
            CommentController().deleteCommentsForPost(post: post)
        })
    }

    private func reportAction(_ post: Post) -> UIAlertAction? {
        guard let postID = post.id, let userID = UserController().fetchUser()?.id else { return nil }
        return UIAlertAction(title: Strings.REPORT_TITLE, style: .default) { _ in
            let report = Report(userID: userID, postID: postID)
            ReportController().setReport(report: report)
        }
    }

    private func deleteAction(_ post: Post, completion: @escaping () -> Void) -> UIAlertAction {
        return UIAlertAction(title: Strings.DELETE_TITLE, style: .destructive) { _ in
            self.deletePost(post: post) {
                completion()
            }
        }
    }

    func optionPost(post: Post?, completionDelete: @escaping () -> Void) {
        guard let post, let userID = UserController().fetchUser()?.id else { return }
        let alert = UIAlertController(title: Strings.OPTION_TITLE, message: nil, preferredStyle: .actionSheet)
        if post.userID == userID {
            let deleteAction = deleteAction(post, completion: completionDelete)
            alert.addAction(deleteAction)
        } else {
            if let reportAction = reportAction(post) {
                alert.addAction(reportAction)
            }
        }
        let cancelAction = UIAlertAction(title: Strings.CANCEL_TITLE, style: .cancel)
        alert.addAction(cancelAction)
        alert._presentVC()
    }
}
