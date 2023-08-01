//
//  UserModel.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 19/07/2023.
//

import Foundation
import CoreLocation

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
    var coordinate: CLLocation?
    var distance: CLLocationDistance?
    var isPrivate: Bool?

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
        self.isPrivate = dictionary["isPrivate"] as? Bool
        self.coordinate = CLLocation(latitude: dictionary["latitude"] as? Double ?? 0, longitude: dictionary["longitude"] as? Double ?? 0)
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
        self.isPrivate = dictionary["isPrivate"] as? Bool
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
            "isPrivate": self.isPrivate,
            "type": self.type?.rawValue
        ]
        if self.type == .User {
            dictionary["latitude"] = self.coordinate?.coordinate.latitude
            dictionary["longitude"] = self.coordinate?.coordinate.longitude
        }
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

    static func > (next: UserModel, previous: UserModel) -> Bool {
        if let previousDistance = previous.distance, let nextDistance = next.distance {
            return previousDistance > nextDistance
        }
        return false
    }

}
