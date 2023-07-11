//
//  AuthController.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 11/07/2023.
//

import Foundation

class AuthController {

    let authKey = "AUHT_KEY"

    func saveAuth(auth: GlobalConstants.UserType) {
        UserDefaults.standard.setValue(auth.rawValue, forKey: authKey)
        UserDefaults.standard.synchronize()
    }

    func fetchAuth() -> GlobalConstants.UserType? {
        guard let auth = UserDefaults.standard.value(forKey: authKey) as? Int else { return nil }
        return GlobalConstants.UserType.User.rawValue == auth ? .User : .Business
    }

    func clearUserDefaults() {
        if let appDomain = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: appDomain)
        }
    }

}
