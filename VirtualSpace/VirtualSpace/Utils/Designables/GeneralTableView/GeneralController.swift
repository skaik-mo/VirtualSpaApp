//
//  GeneralController.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 22/07/2023.
//

import UIKit
import FirebaseFirestore

enum GeneralController {
    case GetPlaces
    case GetPlacesByTherapist(UserModel)
    case GetFavoritePlaces
    case GetTherapists(Place)
    case GetPostsByUser(UserModel)
    case GetPosts

    func sendRequest(lastDocument: QueryDocumentSnapshot?, isShowLoader: Bool, handlerResponse: @escaping ((_ objects: [Any], _ lastDocuments: QueryDocumentSnapshot?, _ headerObject: Any?) -> Void)) -> FirebaseFirestoreController? {
        switch self {
        case .GetPlaces:
            return PlaceController().getPlacesWithPagination(lastDocument: lastDocument, isShowLoader: isShowLoader, handlerResponse: handlerResponse)
        case .GetPlacesByTherapist(let therapist):
            return PlaceController().getPlacesByTherapist(therapist: therapist, lastDocument: lastDocument, isShowLoader: isShowLoader, handlerResponse: handlerResponse)
        case .GetFavoritePlaces:
            return PlaceController().getFavoritePlaces(lastDocument: lastDocument, isShowLoader: isShowLoader, handlerResponse: handlerResponse)
        case .GetTherapists(let place):
            return UserController().getTherapists(place: place, lastDocument: lastDocument, isShowLoader: isShowLoader, handlerResponse: handlerResponse)
        case .GetPostsByUser(let user):
            return PostController().getPostsByUser(user: user, lastDocument: lastDocument, isShowLoader: isShowLoader, handlerResponse: handlerResponse)
        case .GetPosts:
            return PostController().getPosts(lastDocument: lastDocument, isShowLoader: isShowLoader, handlerResponse: handlerResponse)
        }
    }
}
