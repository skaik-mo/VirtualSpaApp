//
//  ReservationController.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 26/07/2023.
//

import FirebaseFirestore

class ReservationController {
    private let referance: FirebaseFirestoreController = FirebaseFirestoreController().setFirebaseReference(.Reservation)

    private func setReservations(_ objects: [Any]) -> [Reservation] {
        var reservations: [Reservation] = []
        objects.forEach { object in
            if let reservation = Reservation.init(dictionary: object as? [String: Any]) {
                reservations.append(reservation)
            }
        }
        return reservations
    }

    func setReservation(reservation: Reservation, success: @escaping () -> Void) -> FirebaseFirestoreController {
        var documentID = UUID().uuidString
        if let id = reservation.id {
            documentID = id
        }
        return self.referance.setData(document: documentID, dictionary: reservation.getDictionary(), success: {
                success()
            })
    }

    func getBusinessPendingReservations(lastDocument: QueryDocumentSnapshot?, isShowLoader: Bool, handlerResponse: @escaping ((_ objects: [Any], _ lastDocuments: QueryDocumentSnapshot?, _ headerObject: Any?) -> Void)) -> FirebaseFirestoreController? {
        guard let therapistID = UserController().fetchUser()?.id else { fatalError("\(#function) The user id is nil") }
        let query = referance.reference?.order(by: "date", descending: true).whereField("therapistID", isEqualTo: therapistID).whereField("status", isEqualTo: ReservationStatus.Pending.rawValue).limit(to: 10)
        return referance.fetchDocuments(query: query, lastDocument: lastDocument, isShowLoader: isShowLoader) { objects, lastDocument in
            guard let lastDocument = lastDocument else { handlerResponse([], nil, nil); return }
            let reservations = self.setReservations(objects)
            handlerResponse(reservations, lastDocument, nil)
        }
    }

    func getBusinessAcceptedReservations(lastDocument: QueryDocumentSnapshot?, isShowLoader: Bool, handlerResponse: @escaping ((_ objects: [Any], _ lastDocuments: QueryDocumentSnapshot?, _ headerObject: Any?) -> Void)) -> FirebaseFirestoreController? {
        guard let therapistID = UserController().fetchUser()?.id else { fatalError("\(#function) The user id is nil") }
        let query = referance.reference?.order(by: "date", descending: true).whereField("therapistID", isEqualTo: therapistID).whereField("status", isEqualTo: ReservationStatus.Accept.rawValue).limit(to: 10)
        return referance.fetchDocuments(query: query, lastDocument: lastDocument, isShowLoader: isShowLoader) { objects, lastDocument in
            guard let lastDocument = lastDocument else { handlerResponse([], nil, nil); return }
            let reservations = self.setReservations(objects)
            handlerResponse(reservations, lastDocument, nil)
        }
    }

    func getMyReservations(lastDocument: QueryDocumentSnapshot?, isShowLoader: Bool, handlerResponse: @escaping ((_ objects: [Any], _ lastDocuments: QueryDocumentSnapshot?, _ headerObject: Any?) -> Void)) -> FirebaseFirestoreController? {
        guard let reservationUserID = UserController().fetchUser()?.id else { fatalError("\(#function) The user id is nil") }
        let query = referance.reference?.order(by: "date", descending: true).whereField("reservationUserID", isEqualTo: reservationUserID).limit(to: 10)
        return referance.fetchDocuments(query: query, lastDocument: lastDocument, isShowLoader: isShowLoader) { objects, lastDocument in
            guard let lastDocument = lastDocument else { handlerResponse([], nil, nil); return }
            let reservations = self.setReservations(objects)
            handlerResponse(reservations, lastDocument, nil)
        }
    }

}
