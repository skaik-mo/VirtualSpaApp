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
        posts = posts.sorted(by: >)
        return posts
    }

    func getPosts(lastDocument: QueryDocumentSnapshot?, isShowLoader: Bool, handlerResponse: @escaping ((_ objects: [Any], _ lastDocuments: QueryDocumentSnapshot?, _ headerObject: Any?) -> Void)) -> FirebaseFirestoreController? {
        return referance.fetchDocuments(limit: 10, lastDocument: lastDocument, isShowLoder: isShowLoader) { objects, lastDocument in
            guard let lastDocument = lastDocument else { handlerResponse([], nil, nil); return }
            let posts = self.setPosts(objects)
            handlerResponse(posts, lastDocument, nil)
        }
    }

    func getPostsByUser(lastDocument: QueryDocumentSnapshot?, isShowLoader: Bool, handlerResponse: @escaping ((_ objects: [Any], _ lastDocuments: QueryDocumentSnapshot?, _ headerObject: Any?) -> Void)) -> FirebaseFirestoreController? {
        guard let user = UserController().fetchUser() else { return referance }
        return referance.fetchDocumentsWithField(field: "user", value: user.getDictionaryForPost(), limit: 10, lastDocument: lastDocument, isShowLoder: isShowLoader) { objects, lastDocument in
            guard let lastDocument = lastDocument else { handlerResponse([], nil, nil); return }
            let posts = self.setPosts(objects)
            handlerResponse(posts, lastDocument, nil)
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
