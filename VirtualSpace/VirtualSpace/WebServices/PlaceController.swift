//
//  PlaceController.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 24/07/2023.
//

import FirebaseFirestore

class PlaceController {

    private let referance: FirebaseFirestoreController = FirebaseFirestoreController().setFirebaseReference(.Place)

    private func setPlaces(_ objects: [Any]) -> [Place] {
        var places: [Place] = []
        objects.forEach { object in
            if let place = Place.init(dictionary: object as? [String: Any]) {
                places.append(place)
            }
        }
        return places
    }

    func getPlaces(isShowLoder: Bool = true, success: @escaping ((_ places: [Place]) -> Void)) -> FirebaseFirestoreController {
        return referance.getDocuments(isShowLoder: isShowLoder) { objects in
            success(self.setPlaces(objects))
        }
    }

    func getPlacesWithPagination(lastDocument: QueryDocumentSnapshot?, isShowLoader: Bool, handlerResponse: @escaping ((_ objects: [Any], _ lastDocuments: QueryDocumentSnapshot?, _ headerObject: Any?) -> Void)) -> FirebaseFirestoreController? {
        return referance.fetchDocuments(limit: 10, lastDocument: lastDocument, isShowLoder: isShowLoader) { objects, lastDocument in
            guard let lastDocument = lastDocument else { handlerResponse([], nil, nil); return }
            let places = self.setPlaces(objects)
            handlerResponse(places, lastDocument, nil)
        }
    }

    func getFavoritePlaces(lastDocument: QueryDocumentSnapshot?, isShowLoader: Bool, handlerResponse: @escaping ((_ objects: [Any], _ lastDocuments: QueryDocumentSnapshot?, _ headerObject: Any?) -> Void)) -> FirebaseFirestoreController? {
        guard let user = UserController().fetchUser() else { return referance }
        return referance.fetchDocumentsWithDocumentIDs(documentIDs: user.favoritePlaces, limit: 10, lastDocument: lastDocument, isShowLoder: isShowLoader) { objects, lastDocument in
            guard let lastDocument = lastDocument else { handlerResponse([], nil, nil); return }
            let places = self.setPlaces(objects)
            handlerResponse(places, lastDocument, nil)
        }
    }

    func addFivoraitePlace(place: Place) {
        guard let placeID = place.id, let user = UserController().fetchUser() else { return }
        if let index = user.favoritePlaces.firstIndex(of: placeID) {
            user.favoritePlaces.remove(at: index)
        } else {
            user.favoritePlaces.append(placeID)
        }
        UserController().setUser(user: user)
    }

}
