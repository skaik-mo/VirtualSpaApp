//
//  UserController.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 11/07/2023.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class UserController: HandlerFinish {

    private let auth = Auth.auth()
    private let userReference = FirebaseFirestoreController().setFirebaseReference(.User)
    private let authKey = "AUHT_KEY"
    var didFinishRequest: (() -> Void)?
    var offlineLoad: (() -> Void)?
    var isLoggedIn: Bool {
        return fetchUser() != nil && auth.currentUser != nil
    }

    func handlerDidFinishRequest(handler: (() -> Void)?) -> Self {
        self.didFinishRequest = handler
        return self
    }

    func handlerofflineLoad(handler: (() -> Void)?) -> Self {
        self.offlineLoad = handler
        return self
    }
}

// MARK: - Auth in UserDefaults
extension UserController {

    private func saveUser(user: UserModel) {
        let data = try? JSONSerialization.data(withJSONObject: user.getDictionary(), options: .fragmentsAllowed)
        UserDefaults.standard.setValue(data, forKey: authKey)
        UserDefaults.standard.synchronize()
    }

    func fetchUser() -> UserModel? {
        guard let data = UserDefaults.standard.value(forKey: authKey) as? Data, let dictionary = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String: Any] else { return nil }
        return .init(dictionary: dictionary)

    }
}

// MARK: - Sign Up
extension UserController {

    func signUp(userModel: UserModel) -> UserController {
        guard Reachability.shared.isConnected() else {
            DispatchQueue.main.async {
                self.offlineLoad?()
            }
            return self
        }
        Helper.showLoader(isLoding: true)
        self.createUser(email: userModel.email, password: userModel.password) { user in
            userModel.id = user.uid
            self.setUser(user: userModel, completion: {
                MainNavigationController.showFirstView()
            })
        }
        return self
    }

    private func createUser(email: String?, password: String?, completion: @escaping (_ user: User) -> Void) {
        guard let email = email, let password = password else { fatalError("\(#function) The email or password is nil") }
        auth.createUser(withEmail: email, password: password) { response, error in
            guard ResponseHandler.responseHandler(error: error), let response else {
                self.didFinishRequest?()
                return
            }
            completion(response.user)
        }
    }

    func setUser(user: UserModel, isShowLoader: Bool = true, isShowMessage: Bool = true, completion: (() -> Void)? = nil) {
        guard let id = user.id else { fatalError("\(#function) The user id is nil") }
        _ = userReference.setData(document: id, dictionary: user.getDictionaryForDatabse(), isShowLoader: isShowLoader, isShowMessage: isShowMessage, success: {
                self.saveUser(user: user)
                completion?()
            }).handlerDidFinishRequest(handler: self.didFinishRequest).handlerofflineLoad(handler: self.offlineLoad)
    }

}

// MARK: - Sign In
extension UserController {

    func signIn(email: String, password: String) -> UserController {
        guard Reachability.shared.isConnected() else {
            DispatchQueue.main.async {
                self.offlineLoad?()
            }
            return self
        }
        Helper.showLoader(isLoding: true)
        auth.signIn(withEmail: email, password: password) { _, error in
            self.didFinishRequest?()
            guard ResponseHandler.responseHandler(error: error) else { return }
            self.getUserData(password: password)
        }
        return self
    }

    private func getUserData(password: String) {
        guard let currentUser = auth.currentUser else { return }
        _ = userReference.fetchDocument(document: currentUser.uid) { dictionary in
            guard let user = UserModel(dictionary: dictionary) else { return }
            user.id = currentUser.uid
            user.email = currentUser.email
            user.password = password
            self.saveUser(user: user)
            MainNavigationController.showFirstView()
        }.handlerDidFinishRequest(handler: didFinishRequest).handlerofflineLoad(handler: offlineLoad)
    }

}

// MARK: - Logout
extension UserController {

    func logout() {
        SceneDelegate.shared?._topVC?._showAlert(message: Strings.CONFIRM_LOGOUT_MESSAGE, buttonAction1: {
            do {
                try self.auth.signOut()
                Helper.clearUserDefaults()
                MainNavigationController.showFirstView()
            } catch let error {
                SceneDelegate.shared?._topVC?._showErrorAlertOK(message: error.localizedFirebaseErrorMessage)
            }
        })
    }
}

// MARK: - Reset || Change Password
extension UserController {

    func passwordReset(_ email: String) -> UserController {
        guard Reachability.shared.isConnected() else {
            DispatchQueue.main.async {
                self.offlineLoad?()
            }
            return self
        }
        Helper.showLoader(isLoding: true)
        auth.sendPasswordReset(withEmail: email) { error in
            self.didFinishRequest?()
            guard ResponseHandler.responseHandler(error: error) else { return }
            Helper.showLoader(isLoding: false)
            SceneDelegate.shared?._topVC?._showAlertOK(message: Strings.RESET_PASSWORD_Message.replacingOccurrences(of: "{email}", with: email))
        }
        return self
    }

    func changePassword(user: UserModel, success: @escaping () -> Void) -> Self {
        guard let newPassword = user.password else { fatalError("\(#function) The new passowrd is nil") }
        guard Reachability.shared.isConnected() else {
            DispatchQueue.main.async {
                self.offlineLoad?()
            }
            return self
        }
        Helper.showLoader(isLoding: true)
        auth.currentUser?.updatePassword(to: newPassword) { error in
            guard ResponseHandler.responseHandler(error: error) else {
                self.didFinishRequest?()
                return
            }
            self.setUser(user: user, completion: success)
            Helper.showLoader(isLoding: false)
            self.didFinishRequest?()
        }
        return self
    }
}

// MARK: - Edit
extension UserController {

    func editCoverImageUser(coverImage: UIImage?) -> Self {
        guard let user = self.fetchUser(), let id = user.id else { fatalError("\(#function) The User is nil") }
        guard Reachability.shared.isConnected() else {
            DispatchQueue.main.async {
                self.offlineLoad?()
            }
            return self
        }
        let coverImagePath = "Users/\(id)/coverImage.jpeg"
        _ = FirebaseStorageController().uploadFile(data: coverImage?.jpegData(compressionQuality: 0.8), path: coverImagePath, handler: { url in
                if let image = url?.absoluteString {
                    user.coverImage = image
                    self.setUser(user: user, isShowLoader: false)
                    Helper.showLoader(isLoding: false)
                }
            }).handlerofflineLoad(handler: self.offlineLoad).handlerDidFinishRequest(handler: { self.didFinishRequest?() })
        return self
    }

    func editUser(user: UserModel, image: UIImage?, imageCompletion: @escaping () -> Void, success: (() -> Void)?) -> Self {
        guard let id = user.id else { fatalError("\(#function) The User id is nil") }
        guard Reachability.shared.isConnected() else {
            DispatchQueue.main.async {
                self.offlineLoad?()
            }
            return self
        }
        Helper.showLoader(isLoding: true)
        self.updateEmail(email: user.email) {
            var data: [String: Data?] = [:]
            let imagePath = "Users/\(id)/userImage.jpeg"
            if let image {
                data[imagePath] = image.jpegData(compressionQuality: 0.8)
            }
            _ = FirebaseStorageController().uploadFiles(data: data, handler: { urls in
                if let image = urls[imagePath]?.absoluteString {
                    imageCompletion()
                    user.image = image
                }
                self.setUser(user: user, completion: success)
            }).handlerofflineLoad(handler: self.offlineLoad).handlerDidFinishRequest(handler: { self.didFinishRequest?() })
        }
        return self
    }

    func updateEmail(email: String?, completion: (() -> Void)?) {
        guard let email, let oldEmail = self.fetchUser()?.email, email != oldEmail else {
            completion?()
            return
        }
        auth.currentUser?.updateEmail(to: email, completion: { error in
            guard ResponseHandler.responseHandler(error: error) else {
                self.didFinishRequest?()
                return
            }
            completion?()
            self.didFinishRequest?()
        })
    }
}

// MARK: - Delete Account
extension UserController {

    func deleteAccount() {
        SceneDelegate.shared?._topVC?._showAlert(styleOK: .destructive, message: Strings.CONFIRM_DELETE_ACCOUNT_MESSAGE, buttonAction1: {
            guard let auth = self.auth.currentUser else { fatalError("\(#function) The User id is nil") }
            let id = auth.uid
            guard Reachability.shared.isConnected() else { return }
            Helper.showLoader(isLoding: true)
            auth.delete { error in
                guard ResponseHandler.responseHandler(error: error) else { return }
//                should delete My reservations, Conversations, Massages, My Friends and Following
                _ = self.userReference.deleteDocument(documentID: id, isShowLoader: false) {
                    let imagePath = "Users/\(id)/userImage.jpeg"
                    let coverImagePath = "Users/\(id)/coverImage.jpeg"
                    FirebaseStorageController().deleteFile(path: imagePath, isShowLoader: false) {
                        FirebaseStorageController().deleteFile(path: coverImagePath, isShowLoader: false) {
                            MainNavigationController.showFirstView()
                            Helper.showLoader(isLoding: false)
                        }
                    }
                }
            }
        })
    }
}

// MARK: - get Users
extension UserController {

    func getTherapists(place: Place, lastDocument: QueryDocumentSnapshot?, isShowLoader: Bool, handlerResponse: @escaping ((_ objects: [Any], _ lastDocuments: QueryDocumentSnapshot?, _ headerObject: Any?) -> Void)) -> FirebaseFirestoreController? {
        guard !place.therapistIDs.isEmpty else {
            handlerResponse([], nil, place)
            DispatchQueue.main.async {
                self.userReference.didFinishRequest?()
            }
            return userReference
        }
        let query = userReference.reference?.limit(to: 10).whereField(FieldPath.documentID(), in: place.therapistIDs)
        return userReference.fetchDocuments(query: query, lastDocument: lastDocument, isShowLoader: isShowLoader) { objects, lastDocument in
            guard let lastDocument else { handlerResponse([], nil, place); return }
            let users = self.setUsers(objects)
            handlerResponse(users, lastDocument, place)
        }
    }

    func getUsersWithIDs(userIDs: [String], isShowLoader: Bool, handlerResponse: @escaping ((_ users: [UserModel]) -> Void)) -> FirebaseFirestoreController? {
        guard !userIDs.isEmpty else {
            handlerResponse([])
            DispatchQueue.main.async {
                self.userReference.didFinishRequest?()
            }
            return userReference
        }
        let query = userReference.reference?.whereField(FieldPath.documentID(), in: userIDs)
        return userReference.fetchDocuments(query: query, lastDocument: nil, isShowLoader: isShowLoader) { objects, _ in
            let users = self.setUsers(objects)
            handlerResponse(users)
        }
    }

    func getNearbyUsers(friends: [Friend], isShowLoader: Bool, handlerResponse: @escaping ((_ objects: [Any], _ lastDocuments: QueryDocumentSnapshot?, _ headerObject: Any?) -> Void)) -> FirebaseFirestoreController {
        guard let user = self.fetchUser(), let id = user.id, let coordinate = user.coordinate else {
            handlerResponse([], nil, nil)
            DispatchQueue.main.async {
                self.userReference.didFinishRequest?()
            }
            return userReference
        }
        let query = userReference.reference?.whereField("type", isEqualTo: 0).whereField(FieldPath.documentID(), isNotEqualTo: id)
        return userReference.fetchDocuments(query: query, lastDocument: nil, isShowLoader: isShowLoader) { objects, _ in
            var users = self.setUsers(objects)
            users.forEach { user in
                user.distance = user.coordinate?.distance(from: coordinate)
            }
            users.sort(by: >)
            let nearby: [(UserModel, Bool)] = users.map { user in
                if friends.contains(where: { $0.userIDs.contains(where: { $0 == user.id }) }) {
                    return (user, false)
                }
                return (user, true)
            }
            handlerResponse(nearby, nil, nil)
        }
    }

    private func setUsers(_ objects: [Any]) -> [UserModel] {
        var users: [UserModel] = []
        objects.forEach { object in
            if let user = UserModel.init(dictionary: object as? [String: Any]) {
                users.append(user)
            }
        }
        return users
    }
}

// MARK: - set Privacy
extension UserController {

    func setPrivacy(isPrivate: Bool) {
        guard let user = self.fetchUser() else { return }
        user.isPrivate = isPrivate
        self.setUser(user: user, isShowLoader: false)
    }
}
