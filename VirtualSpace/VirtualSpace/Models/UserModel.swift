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
    var countryCode: String?
    var phone: String?
    var bio: String?
    var image: String?
    var coverImage: String?
    var favoritePosts: [String] = []
    var favoritePlaces: [String] = []
    var type: GlobalConstants.UserType?

    init(id: String? = nil, email: String? = nil, password: String? = nil, name: String? = nil, countryCode: String? = nil, phone: String? = nil, bio: String? = nil, image: String? = nil, coverImage: String? = nil, type: GlobalConstants.UserType? = nil) {
        self.id = id
        self.email = email
        self.password = password
        self.name = name
        self.countryCode = countryCode
        self.phone = phone
        self.bio = bio
        self.image = image
        self.coverImage = coverImage
        self.type = type
    }

    init?(dictionary: [String: Any]?) {
        guard let dictionary, !dictionary.isEmpty else { return nil }
        self.id = dictionary["id"] as? String
        self.email = dictionary["email"] as? String
        self.password = dictionary["password"] as? String
        self.countryCode = dictionary["countryCode"] as? String
        self.phone = dictionary["phone"] as? String
        self.name = dictionary["name"] as? String
        self.bio = dictionary["bio"] as? String
        self.image = dictionary["image"] as? String
        self.coverImage = dictionary["coverImage"] as? String
        self.favoritePosts = dictionary["favoritePosts"] as? [String] ?? []
        self.favoritePlaces = dictionary["favoritePlaces"] as? [String] ?? []
        if let type = dictionary["type"] as? Int {
            self.type = type == 0 ? .User : .Business
        }
    }

    init?(id: String?, dictionary: [String: Any]?) {
        guard let dictionary, !dictionary.isEmpty else { return nil }
        self.id = id
        self.email = dictionary["email"] as? String
        self.password = dictionary["password"] as? String
        self.countryCode = dictionary["countryCode"] as? String
        self.phone = dictionary["phone"] as? String
        self.name = dictionary["name"] as? String
        self.bio = dictionary["bio"] as? String
        self.image = dictionary["image"] as? String
        self.coverImage = dictionary["coverImage"] as? String
        self.favoritePosts = dictionary["favoritePosts"] as? [String] ?? []
        self.favoritePlaces = dictionary["favoritePlaces"] as? [String] ?? []
        if let type = dictionary["type"] as? Int {
            self.type = type == 0 ? .User : .Business
        }
    }

    func getDictionary() -> [String: Any] {
        var dictionary: [String: Any] = self.getDictionaryForDatabse()
        dictionary["id"] = self.id
        return dictionary
    }

    func getDictionaryForDatabse() -> [String: Any] {
        var dictionary: [String: Any?] = [
            "email": self.email,
            "password": self.password,
            "name": self.name,
            "countryCode": self.countryCode,
            "phone": self.phone,
            "image": self.image,
            "coverImage": self.coverImage,
            "favoritePosts": self.favoritePosts,
            "favoritePlaces": self.favoritePlaces,
            "type": self.type?.rawValue
        ]
        if self.type == .Business {
            dictionary["bio"] = self.bio
        }
        return dictionary as [String: Any]
    }

    func getDictionaryForPost() -> [String: Any] {
        let dictionary: [String: Any?] = [
            "id": self.id,
            "name": self.name,
            "image": self.image
        ]
        return dictionary as [String: Any]
    }

}
