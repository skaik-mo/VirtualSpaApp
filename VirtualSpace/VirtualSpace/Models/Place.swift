//
//  Place.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 24/07/2023.
//

import Foundation
import CoreLocation

class Place {
    var id: String?
    var name: String?
    var address: String?
    var description: String?
    var icon: String?
    var coverImage: String?
    var audio: String?
    var audioName: String?
    var images: [String] = []
    var categories: [String] = []
    var subCategories: [String] = []
    var therapistIDs: [String] = []
    var isFavorite: Bool = false
    var coordinate: CLLocation?
    var time: Double?
    var distance: Double?

    init?(dictionary: [String: Any]?) {
        guard let dictionary, !dictionary.isEmpty else { return nil }
        self.id = dictionary["id"] as? String
        self.name = dictionary["name"] as? String
        self.address = dictionary["address"] as? String
        self.description = dictionary["description"] as? String
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
        if let latitude = dictionary["latitude"] as? Double, let longitude = dictionary["longitude"] as? Double, let coordinate = UserController().fetchUser()?.coordinate {
            self.coordinate = CLLocation(latitude: latitude, longitude: longitude)
            let distanceInMeter = (self.coordinate?.distance(from: coordinate) ?? 0)
            let mi = 1609.3471
            self.distance = distanceInMeter / mi
            let averageCarSpeed = 60.0
            self.time = distanceInMeter / averageCarSpeed * 1000 / 3600
        }
    }

    func getDictionary() -> [String: Any] {
        let dictionary: [String: Any?] = [
            "id": self.id,
            "name": self.name,
            "address": self.address,
            "description": self.description,
            "icon": self.icon,
            "coverImage": self.coverImage,
            "audio": self.audio,
            "audioName": self.audioName,
            "images": self.images,
            "categories": self.categories,
            "subCategories": self.subCategories,
            "therapists": self.therapistIDs,
            "latitude": self.coordinate?.coordinate.latitude,
            "longitude": self.coordinate?.coordinate.longitude
        ]
        return dictionary as [String: Any]
    }

    func getTimeAndDistance() -> String {
        var time = ""
        var distance = ""
        if let _distance = self.distance?._toString {
            distance = "\(_distance) mi"
        }
        if let _time = self.time?._toString {
            time = "\(_time) min"
        }
        return "\(time) . \(distance)"
    }

}
