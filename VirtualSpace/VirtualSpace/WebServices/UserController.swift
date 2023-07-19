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
        guard Reachability.shared.isConnected else {
            DispatchQueue.main.async {
                self.offlineLoad?()
            }
            return self
        }
        Helper.showLoader(isLoding: true)
        self.createUser(email: userModel.email, password: userModel.password) { user in
            userModel.id = user.uid
            self.setUser(user: userModel)
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

    private func setUser(user: UserModel) {
        guard let id = user.id else { fatalError("\(#function) The user id is nil") }
        _ = userReference.setData(document: id, dictionary: user.getDictionary(), success: {
                self.saveUser(user: user)
                MainNavigationController.showFirstView()
            }).handlerDidFinishRequest(handler: self.didFinishRequest).handlerofflineLoad(handler: self.offlineLoad)
    }

}

// MARK: - Sign In
extension UserController {

    func signIn(email: String, password: String) -> UserController {
        guard Reachability.shared.isConnected else {
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

// MARK: - Logout && Change Password
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
