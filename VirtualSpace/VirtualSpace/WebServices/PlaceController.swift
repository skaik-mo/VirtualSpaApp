//
//  PlaceController.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 24/07/2023.
//

import Foundation

class PlaceController {

    private let referance: FirebaseFirestoreController = FirebaseFirestoreController().setFirebaseReference(.Place)

    func getPlaces(isShowLoder: Bool = true, success: @escaping ((_ places: [Place]) -> Void)) -> FirebaseFirestoreController {
        return referance.getDocuments(isShowLoder: isShowLoder) { objects in
            var places: [Place] = []
            objects.forEach { object in
                if let place = Place.init(dictionary: object as? [String: Any]) {
                    places.append(place)
                }
            }
            success(places)
        }
    }
}
