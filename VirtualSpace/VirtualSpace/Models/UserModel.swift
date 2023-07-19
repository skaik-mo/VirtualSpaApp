//
//  UserModel.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 19/07/2023.
//

import Foundation

class UserModel {
    var id: String?
    var email: String?
    var password: String?
    var name: String?
    var phone: String?
    var bio: String?
    var image: String?
    var type: GlobalConstants.UserType?

    init(id: String? = nil, email: String? = nil, password: String? = nil, name: String? = nil, phone: String? = nil, bio: String? = nil, image: String? = nil, type: GlobalConstants.UserType? = nil) {
        self.id = id
        self.email = email
        self.password = password
        self.name = name
        self.phone = phone
        self.bio = bio
        self.image = image
        self.type = type
    }

    init?(dictionary: [String: Any]?) {
        guard let dictionary, !dictionary.isEmpty else { return nil }
        self.id = dictionary["id"] as? String
        self.email = dictionary["email"] as? String
        self.password = dictionary["password"] as? String
        self.phone = dictionary["phone"] as? String
        self.name = dictionary["name"] as? String
        self.bio = dictionary["bio"] as? String
        self.image = dictionary["image"] as? String
        self.type = (dictionary["type"] as? Int) == 0 ? .User : .Business
    }

    func getDictionary() -> [String: Any] {
        var dictionary: [String: Any] = self.getDictionaryForDatabse()
        dictionary["id"] = self.id
        dictionary["email"] = self.email
        dictionary["password"] = self.password
        return dictionary
    }

    func getDictionaryForDatabse() -> [String: Any] {
        let dictionary: [String: Any?] = [
            "name": self.name,
            "phone": self.phone,
            "bio": self.bio,
            "image": self.image,
            "type": self.type?.rawValue
        ]
        return dictionary as [String: Any]
    }

}
