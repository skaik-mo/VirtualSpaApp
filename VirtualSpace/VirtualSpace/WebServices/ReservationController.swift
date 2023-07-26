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
        reservations = reservations.sorted(by: >)
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

    private func getReservations(field: String, value: Any, lastDocument: QueryDocumentSnapshot?, isShowLoader: Bool, handlerResponse: @escaping ((_ objects: [Any], _ lastDocuments: QueryDocumentSnapshot?, _ headerObject: Any?) -> Void)) -> FirebaseFirestoreController? {
        return referance.fetchDocumentsWithField(field: field, value: value, limit: 10, lastDocument: lastDocument, isShowLoder: isShowLoader) { objects, lastDocument in
            guard let lastDocument = lastDocument else { handlerResponse([], nil, nil); return }
            handlerResponse(objects, lastDocument, nil)
        }
    }

    func getBusinessPendingReservations(lastDocument: QueryDocumentSnapshot?, isShowLoader: Bool, handlerResponse: @escaping ((_ objects: [Any], _ lastDocuments: QueryDocumentSnapshot?, _ headerObject: Any?) -> Void)) -> FirebaseFirestoreController? {
        guard let therapistID = UserController().fetchUser()?.id else { fatalError("\(#function) The user id is nil") }
        return self.getReservations(field: "therapistID", value: therapistID, lastDocument: lastDocument, isShowLoader: isShowLoader) { objects, _, _ in
            var reservations = self.setReservations(objects)
            reservations = reservations.filter({ $0.status == .Pending })
            handlerResponse(reservations, lastDocument, nil)
        }
    }

    func getBusinessAcceptedReservations(lastDocument: QueryDocumentSnapshot?, isShowLoader: Bool, handlerResponse: @escaping ((_ objects: [Any], _ lastDocuments: QueryDocumentSnapshot?, _ headerObject: Any?) -> Void)) -> FirebaseFirestoreController? {
        guard let therapistID = UserController().fetchUser()?.id else { fatalError("\(#function) The user id is nil") }
        return self.getReservations(field: "therapistID", value: therapistID, lastDocument: lastDocument, isShowLoader: isShowLoader) { objects, _, _ in
            var reservations = self.setReservations(objects)
            reservations = reservations.filter({ $0.status == .Accept })
            handlerResponse(reservations, lastDocument, nil)
        }
    }

    func getMyReservations(lastDocument: QueryDocumentSnapshot?, isShowLoader: Bool, handlerResponse: @escaping ((_ objects: [Any], _ lastDocuments: QueryDocumentSnapshot?, _ headerObject: Any?) -> Void)) -> FirebaseFirestoreController? {
        guard let reservationUserID = UserController().fetchUser()?.id else { fatalError("\(#function) The user id is nil") }
        return self.getReservations(field: "reservationUserID", value: reservationUserID, lastDocument: lastDocument, isShowLoader: isShowLoader) { objects, _, _ in
            let reservations = self.setReservations(objects)
            handlerResponse(reservations, lastDocument, nil)
        }
    }

}
