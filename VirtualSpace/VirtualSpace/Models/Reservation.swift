//
//  Reservation.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 26/07/2023.
//

import Foundation

enum ReservationStatus: Int {
    case Pending = 0
    case Accept = 1
    case Reject = 2

    static func getStatus(status: Int?) -> Self {
        switch status {
        case 2:
            return .Reject
        case 1:
            return .Accept
        default:
            return .Pending
        }
    }
}

class Reservation {
    var id: String?
    var therapistID: String?
    var therapistName: String?
    var therapistImage: String?
    var reservationUserID: String?
    var reservationUserName: String?
    var reservationUserEmail: String?
    var reservationUserPhone: String?
    var reservationUserImage: String?
    var reservationUserCoverImage: String?
    var date: Date?
    var status: ReservationStatus = .Pending

    init(id: String? = nil, therapistID: String?, therapistName: String?,
         therapistImage: String?, reservationUserID: String?, reservationUserName: String?,
         reservationUserEmail: String?, reservationUserPhone: String?, reservationUserImage: String?,
         reservationUserCoverImage: String?, date: Date?, status: ReservationStatus) {
        self.id = id
        self.therapistID = therapistID
        self.therapistName = therapistName
        self.therapistImage = therapistImage
        self.reservationUserID = reservationUserID
        self.reservationUserName = reservationUserName
        self.reservationUserEmail = reservationUserEmail
        self.reservationUserPhone = reservationUserPhone
        self.reservationUserImage = reservationUserImage
        self.reservationUserCoverImage = reservationUserCoverImage
        self.date = date
        self.status = status
    }

    init?(dictionary: [String: Any]?) {
        guard let dictionary, !dictionary.isEmpty else { return nil }
        self.id = dictionary["id"] as? String
        self.therapistID = dictionary["therapistID"] as? String
        self.therapistName = dictionary["therapistName"] as? String
        self.therapistImage = dictionary["therapistImage"] as? String
        self.reservationUserID = dictionary["reservationUserID"] as? String
        self.reservationUserName = dictionary["reservationUserName"] as? String
        self.reservationUserEmail = dictionary["reservationUserEmail"] as? String
        self.reservationUserPhone = dictionary["reservationUserPhone"] as? String
        self.reservationUserImage = dictionary["reservationUserImage"] as? String
        self.reservationUserCoverImage = dictionary["reservationUserCoverImage"] as? String
        self.date = Date.init(timeIntervalSince1970: (dictionary["date"] as? Double) ?? Date().timeIntervalSince1970)
        self.status = ReservationStatus.getStatus(status: dictionary["status"] as? Int)
    }

    func getDictionary() -> [String: Any] {
        let dictionary: [String: Any?] = [
//            "id": self.id,
            "therapistID": self.therapistID,
            "therapistName": self.therapistName,
            "therapistImage": self.therapistImage,
            "reservationUserID": self.reservationUserID,
            "reservationUserName": self.reservationUserName,
            "reservationUserEmail": self.reservationUserEmail,
            "reservationUserPhone": self.reservationUserPhone,
            "reservationUserImage": self.reservationUserImage,
            "reservationUserCoverImage": self.reservationUserCoverImage,
            "date": self.date?.timeIntervalSince1970,
            "status": self.status.rawValue
        ]
        return dictionary as [String: Any]
    }
}
