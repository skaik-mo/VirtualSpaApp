//
//  Place.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 24/07/2023.
//

import Foundation

class Place {
    var id: String?
    var name: String?
    var address: String?
    var description: String?
    var time: String?
    var distance: String?
    var icon: String?
    var coverImage: String?
    var audio: String?
    var audioName: String?
    var images: [String] = []
    var categories: [String] = []
    var subCategories: [String] = []
    var therapistIDs: [String] = []
    var isFavorite: Bool = false

    init?(dictionary: [String: Any]?) {
        guard let dictionary, !dictionary.isEmpty else { return nil }
        self.id = dictionary["id"] as? String
        self.name = dictionary["name"] as? String
        self.address = dictionary["address"] as? String
        self.description = dictionary["description"] as? String
        self.time = dictionary["time"] as? String
        self.distance = dictionary["distance"] as? String
        self.icon = dictionary["icon"] as? String
        self.coverImage = dictionary["coverImage"] as? String
        self.audio = dictionary["audio"] as? String
        self.audioName = dictionary["audioName"] as? String
        self.images = dictionary["images"] as? [String] ?? []
        self.categories = dictionary["categories"] as? [String] ?? []
        self.subCategories = dictionary["subCategories"] as? [String] ?? []
        self.isFavorite = UserController().fetchUser()?.favoritePlaces.contains(self.id ?? "") ?? false
        for object in dictionary["therapists"] as? [String] ?? [] {
                self.therapistIDs.append(object)
        }
    }

    func getTimeAndDistance() -> String {
        var time = ""
        var distance = ""
        if let _distance = self.distance {
            distance = "\(_distance) im"
        }
        if let _time = self.time {
            time = "\(_time) min"
        }
        return "\(time) . \(distance)"
    }

}
