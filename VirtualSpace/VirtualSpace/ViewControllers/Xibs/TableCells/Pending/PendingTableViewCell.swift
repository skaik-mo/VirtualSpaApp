// _________SKAIK_MO_________
//
//  PendingTableViewCell.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 13/07/2023.
//

import UIKit

class PendingTableViewCell: GeneralTableViewCell {

    @IBOutlet weak var authImage: rImage!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var rejectButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func configureCell() {
        self.acceptButton.title = Strings.ACCEPT_TITLE
        self.rejectButton.title = Strings.REJECT_TITLE
        self.acceptButton.applyButtonStyle(.SecondaryGreen)
        self.rejectButton.applyButtonStyle(.SecondaryRed)
        if let object = object as? Reservation {
            self.authImage.fetchImage(object.reservationUserImage, .ic_placeholder)
            self.nameLabel.text = object.reservationUserName
            self.dateLabel.text = object.date?._stringDate
        } else {
            self.authImage.image = nil
            self.nameLabel.text = nil
            self.dateLabel.text = nil
        }
    }

    @IBAction func acceptAction(_ sender: Any) {
        self.setStatus(.Accept)
        self.sendNotification()
    }

    @IBAction func rejectAction(_ sender: Any) {
        self.setStatus(.Reject)
    }

    private func setStatus(_ status: ReservationStatus) {
        guard let object = object as? Reservation,
            let _topVC = self._topVC as? OrdersViewController,
            let parent = _topVC.viewControllers.first(where: { $0 is OrdersPendingViewController }) as? OrdersPendingViewController,
            let index = parent.tableView.objects.firstIndex(where: { ($0 as? Reservation)?.id == object.id }) else { return }
        object.status = status
        _ = ReservationController().setReservation(reservation: object) {
            parent.tableView.objects.remove(at: index)
        }
    }

    func sendNotification() {
        guard let object = object as? Reservation, let recipientID = object.reservationUserID, let sender = UserController().fetchUser(), let senderId = sender.id, let senderName = sender.name else { return }
        let notification = Notification.init(
            sender: senderId,
            recipient: recipientID,
            type: .Accept,
            title: senderName,
            body: Strings.ACCEPT_RESERVATAION_BODY,
            image: sender.image,
            data: ["sender": sender.getDictionary()])
        NotificationController().sendNotification(notification: notification, isShowLoader: false)
    }

}
