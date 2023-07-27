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
    case GetMyReservations
    case GetBusinessPendingReservations
    case GetBusinessAcceptedReservations
    case GetCommentsForPost(Post)
    case GetFollowing
    case GetFollowers
    case GetConversations

    // swiftlint:disable cyclomatic_complexity
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
        case .GetMyReservations:
            return ReservationController().getMyReservations(lastDocument: lastDocument, isShowLoader: isShowLoader, handlerResponse: handlerResponse)
        case .GetBusinessPendingReservations:
            return ReservationController().getBusinessPendingReservations(lastDocument: lastDocument, isShowLoader: isShowLoader, handlerResponse: handlerResponse)
        case .GetBusinessAcceptedReservations:
            return ReservationController().getBusinessAcceptedReservations(lastDocument: lastDocument, isShowLoader: isShowLoader, handlerResponse: handlerResponse)
        case .GetCommentsForPost(let post):
            return CommentController().getCommentsForPost(post: post, lastDocument: lastDocument, isShowLoader: isShowLoader, handlerResponse: handlerResponse)
        case .GetFollowing:
            return FollowController().getFollowing(lastDocument: lastDocument, isShowLoader: isShowLoader, handlerResponse: handlerResponse)
        case .GetFollowers:
            return FollowController().getFollowers(lastDocument: lastDocument, isShowLoader: isShowLoader, handlerResponse: handlerResponse)
        case .GetConversations:
            return ConversationController().getConversations(isShowLoader: isShowLoader) { objects, headerObject in
                handlerResponse(objects, nil, headerObject)
            }
        }
    }
}
