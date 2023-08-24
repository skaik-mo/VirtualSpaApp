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

    func getPlaces(isShowLoader: Bool = true, success: @escaping ((_ places: [Place]) -> Void)) -> FirebaseFirestoreController {
        return referance.fetchDocuments(isShowLoader: isShowLoader) { objects in
            success(self.setPlaces(objects))
        }
    }

    func getPlacesWithPagination(lastDocument: QueryDocumentSnapshot?, isShowLoader: Bool, handlerResponse: @escaping ((_ objects: [Any], _ lastDocuments: QueryDocumentSnapshot?, _ headerObject: Any?) -> Void)) -> FirebaseFirestoreController? {
        let query = referance.reference?.limit(to: 10)
        return referance.fetchDocuments(query: query, lastDocument: lastDocument, isShowLoader: isShowLoader) { objects, lastDocument in
            guard let lastDocument = lastDocument else { handlerResponse([], nil, nil); return }
            let places = self.setPlaces(objects)
            handlerResponse(places, lastDocument, nil)
        }
    }

    func getPlacesByTherapist(therapist: UserModel, lastDocument: QueryDocumentSnapshot?, isShowLoader: Bool, handlerResponse: @escaping ((_ objects: [Any], _ lastDocuments: QueryDocumentSnapshot?, _ headerObject: Any?) -> Void)) -> FirebaseFirestoreController? {
        guard let id = therapist.id else { return referance }
        let query = referance.reference?.limit(to: 10).whereField("therapists", arrayContains: id)
        return referance.fetchDocuments(query: query, lastDocument: lastDocument, isShowLoader: isShowLoader) { objects, lastDocument in
            guard let lastDocument = lastDocument else { handlerResponse([], nil, therapist); return }
            var _objects: [Any] = self.setPlaces(objects)
            _objects.insert(therapist, at: 0)
            handlerResponse(_objects, lastDocument, therapist)
        }
    }

    func getFavoritePlaces(lastDocument: QueryDocumentSnapshot?, isShowLoader: Bool, handlerResponse: @escaping ((_ objects: [Any], _ lastDocuments: QueryDocumentSnapshot?, _ headerObject: Any?) -> Void)) -> FirebaseFirestoreController? {
        guard let user = UserController().fetchUser(), !user.favoritePlaces.isEmpty else {
            handlerResponse([], nil, nil)
            DispatchQueue.main.async {
                self.referance.didFinishRequest?()
            }
            return referance
        }
        let query = referance.reference?.limit(to: 10).whereField(FieldPath.documentID(), in: user.favoritePlaces)
        return referance.fetchDocuments(query: query, lastDocument: lastDocument, isShowLoader: isShowLoader) { objects, lastDocument in
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
