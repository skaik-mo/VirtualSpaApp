// _________SKAIK_MO_________
//
//  NotificationTableViewCell.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 12/07/2023.
//

import UIKit

class NotificationTableViewCell: GeneralTableViewCell {

    @IBOutlet weak var notifyImage: rImage!
    @IBOutlet weak var notifyTtitleLabel: UILabel!
    @IBOutlet weak var notifyDateLabel: UILabel!
    @IBOutlet weak var notifyDescrition: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func configureCell() {
        if let object = object as? Notification {
            self.notifyImage.fetchImage(object.image, .ic_placeholder)
            self.notifyTtitleLabel.text = object.title
            self.notifyDescrition.text = object.body
            self.notifyDateLabel.text = object.createdAt?._timeAgoDisplay
        } else {
            self.notifyImage.image = nil
            self.notifyTtitleLabel.text = nil
            self.notifyDescrition.text = nil
            self.notifyDateLabel.text = nil
        }
    }

    override func didselect(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let object = object as? Notification else { return }
        switch object.type {
        case .Alert:
            break
        case .Message:
            self.showMessage(object)
        case .Invite:
            self.showInvitation(object)
        case .Following:
            self.showFollowing(object)
        case .Friend:
            self.showFriend(object)
        case .Accept:
            self.showAcceptReservation(object)
        }
    }

    private func showMessage(_ notification: Notification) {
        guard let conversationID = notification.data?["conversationID"] as? String, let sender = UserModel(dictionary: notification.data?["sender"] as? [String: Any]) else { return }
        let vc = ChatViewController(otherUser: sender)
        vc.conversationID = conversationID
        vc._push()
    }

    private func showInvitation(_ notification: Notification) {
        guard let place = Place(dictionary: notification.data?["place"] as? [String: Any]) else { return }
        let vc = PlaceDetailsViewController(place: place)
        vc._push()
    }

    private func showFriend(_ notification: Notification) {
        guard let friend = Friend(dictionary: notification.data?["friend"] as? [String: Any]), let user = friend.users.first(where: { $0.id == notification.sender }) else { return }
        // if you want pass friend should remove notification if user make unfriend
        let vc = UserDetailsViewController(user: user, friend: nil)
        vc._push()
    }

    private func showFollowing(_ notification: Notification) {
        guard let user = UserModel(dictionary: notification.data?["sender"] as? [String: Any]) else { return }
        let vc = UserDetailsViewController(user: user, friend: nil)
        vc.isHidenFriendButton = true
        vc._push()
    }

    private func showAcceptReservation(_ notification: Notification) {
        guard let user = UserModel(dictionary: notification.data?["sender"] as? [String: Any]) else { return }
        let vc = TherapistViewController(therapist: user)
        vc._push()
    }

}
