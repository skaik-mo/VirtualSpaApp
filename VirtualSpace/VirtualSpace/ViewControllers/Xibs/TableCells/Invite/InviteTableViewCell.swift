// _________SKAIK_MO_________
//
//  InviteTableViewCell.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 12/07/2023.
//

import UIKit

class InviteTableViewCell: GeneralTableViewCell {

    @IBOutlet weak var authImage: rImage!
    @IBOutlet weak var authNameLabel: UILabel!
    @IBOutlet weak var inviteButton: UIButton!
    enum InvieteStyle {
        case Add, Invite, Invited
    }
    private var style: InvieteStyle = .Add {
        didSet {
            self.setCustmizeButton()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func configureCell() {
        self.style = .Add
        if let object = object as? (user: UserModel, isAdd: Bool), let id = object.user.id {
            self.authImage.fetchImage(object.user.image, .ic_placeholder)
            self.authNameLabel.text = object.user.name
            if let _topVC = _topVC as? InviteViewController {
                self.style = _topVC.invitedUserIDs.contains(id) ? .Invited : object.isAdd ? .Add : .Invite
            }
        } else {
            self.authImage.image = nil
            self.authNameLabel.text = nil
        }
    }

    private func setCustmizeButton() {
        switch self.style {
        case .Add:
            self.inviteButton.titleLabel?.text = Strings.ADD_TITLE
            self.inviteButton.applyButtonStyle(.Primary(35))
        case .Invite:
            self.inviteButton.titleLabel?.text = Strings.INVITE_TITLE
            self.inviteButton.applyButtonStyle(.OutlinedPurple(35))
        case .Invited:
            self.inviteButton.titleLabel?.text = Strings.INVITED_TITLE
            self.inviteButton.applyButtonStyle(.SecondaryLightPurple(35))
        }
    }

    @IBAction func inviteAction(_ sender: Any) {
        switch self.style {
        case .Add:
            self.addFriend()
            self.style = .Invite
        case .Invite:
            self.sendInvitation()
            self.style = .Invited
        case .Invited:
            break
        }
    }

    override func didselect(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let object = object as? (user: UserModel, isAdd: Bool) else { return }
        let vc = UserDetailsViewController(user: object.user, friend: nil)
        vc._push()
    }

}

// MARK: - Add Friend
private extension InviteTableViewCell {
    func sendNewFreindNotification(_ friend: Friend) {
        guard let object = object as? (user: UserModel, isAdd: Bool), let sender = UserController().fetchUser(), let senderId = sender.id, let senderName = sender.name, let recipientID = object.user.id else { return }
        let notification = Notification.init(
            sender: senderId,
            recipient: recipientID,
            type: .Friend,
            title: Strings.NEW_FRIEND_TITLE,
            body: Strings.NEW_FRIEND_BODY.replacingOccurrences(of: "{senderName}", with: senderName),
            image: sender.image,
            data: ["friend": friend.getDictionary()])
        NotificationController().sendNotification(notification: notification, isShowLoader: false)
    }

    private func addFriend() {
        guard let object = object as? (user: UserModel, isAdd: Bool), let userID = object.user.id, let auth = UserController().fetchUser(), let authID = auth.id else { return }
        let friend = Friend(userIDs: [userID, authID], users: [object.user, auth])
        _ = FriendController().addFriend(friend: friend) {
            self.sendNewFreindNotification(friend)
        }
    }

}

// MARK: - Invite
private extension InviteTableViewCell {

    func sendInvitation() {
        guard let object = object as? (user: UserModel, isAdd: Bool), let recipientID = object.user.id,
            let sender = UserController().fetchUser(), let senderID = sender.id, let senderName = sender.name,
            let _topVC = _topVC as? InviteViewController, let placeName = _topVC.place.name else { return }
        _topVC.invitedUserIDs.append(recipientID)
        var body = Strings.INVITATION_BODY.replacingOccurrences(of: "{senderName}", with: senderName)
        body = body.replacingOccurrences(of: "{placeName}", with: placeName)
        let notification = Notification.init(sender: senderID, recipient: recipientID, type: .Invite, title: Strings.INVITATION_TITLE, body: body, image: _topVC.place.icon, data: ["place": _topVC.place.getDictionary()])
        NotificationController().sendNotification(notification: notification, isShowLoader: false)
    }
}
