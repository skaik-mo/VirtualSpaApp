//
//  SubCategory.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 24/07/2023.
//

import Foundation

class SubCategory {
    var id: String?
    var name: String?
    var image: String?

    init?(dictionary: [String: Any]?) {
        guard let dictionary, !dictionary.isEmpty else { return nil }
        self.id = dictionary["id"] as? String
        self.name = dictionary["name"] as? String
        self.image = dictionary["image"] as? String
    }

}
