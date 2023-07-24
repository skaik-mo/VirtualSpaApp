//
//  UserController.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 11/07/2023.
//

import UIKit
import FirebaseAuth

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

    private func setUser(user: UserModel, completion: (() -> Void)? = nil) {
        guard let id = user.id else { fatalError("\(#function) The user id is nil") }
        _ = userReference.setData(document: id, dictionary: user.getDictionaryForDatabse(), success: {
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
        _ = userReference.getDocument(document: currentUser.uid) { dictionary in
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
        AppDelegate.shared?._topVC?._showAlert(message: Strings.CONFIRM_LOGOUT_MESSAGE, buttonAction1: {
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

    func changePassword(user: UserModel) -> Self {
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
            self.saveUser(user: user)
            Helper.showLoader(isLoding: false)
            self.didFinishRequest?()
        }
        return self
    }
}

// MARK: - Edit
extension UserController {

    func editUser(user: UserModel, image: UIImage?, coverImage: UIImage?, imageCompletion: @escaping (_ isCoverImage: Bool) -> Void) -> Self {
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
            let coverImagePath = "Users/\(id)/coverImage.jpeg"
            if let image {
                data[imagePath] = image.jpegData(compressionQuality: 0.8)
            }
            if let coverImage {
                data[coverImagePath] = coverImage.jpegData(compressionQuality: 0.8)
            }
            _ = FirebaseStorageController().uploadFiles(data: data, handler: { urls in
                if let image = urls[imagePath]?.absoluteString {
                    imageCompletion(false)
                    user.image = image
                }
                if let coverImage = urls[coverImagePath]?.absoluteString {
                    imageCompletion(true)
                    user.coverImage = coverImage
                }
                self.setUser(user: user)
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
        AppDelegate.shared?._topVC?._showAlert(message: Strings.CONFIRM_DELETE_ACCOUNT_MESSAGE, buttonAction1: {
            guard let auth = self.auth.currentUser else { fatalError("\(#function) The User id is nil") }
            let id = auth.uid
            guard Reachability.shared.isConnected() else { return }
            Helper.showLoader(isLoding: true)
            auth.delete { error in
                guard ResponseHandler.responseHandler(error: error) else { return }
                self.userReference.deleteDocument(document: id, isShowLoder: false) {
                    let imagePath = "Users/\(id)/userImage.jpeg"
                    let coverImagePath = "Users/\(id)/coverImage.jpeg"
                    FirebaseStorageController().deleteFile(path: imagePath, isShowLoder: false) {
                        FirebaseStorageController().deleteFile(path: coverImagePath, isShowLoder: false) {
                            MainNavigationController.showFirstView()
                            Helper.showLoader(isLoding: false)
                        }
                    }
                }
            }
        })
    }
}
