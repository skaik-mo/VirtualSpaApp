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
    var time: String?
    var distance: String?
    var images: [String] = []
    var categories: [String] = []
    var subCategories: [String] = []

    init?(dictionary: [String: Any]?) {
        guard let dictionary, !dictionary.isEmpty else { return nil }
        self.id = dictionary["id"] as? String
        self.name = dictionary["name"] as? String
        self.address = dictionary["address"] as? String
        self.time = dictionary["time"] as? String
        self.distance = dictionary["distance"] as? String
        self.images = dictionary["images"] as? [String] ?? []
        self.categories = dictionary["categories"] as? [String] ?? []
        self.subCategories = dictionary["subCategories"] as? [String] ?? []
    }

}
