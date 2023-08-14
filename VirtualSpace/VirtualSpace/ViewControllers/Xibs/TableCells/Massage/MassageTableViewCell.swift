// _________SKAIK_MO_________
//
//  MassageTableViewCell.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 13/07/2023.
//

import UIKit

class MassageTableViewCell: GeneralTableViewCell {

    @IBOutlet weak var authImage: rImage!
    @IBOutlet weak var authNameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func configureCell() {
        if let authID = UserController().fetchUser()?.id, let object = object as? Conversation, let user = object.users.first(where: { $0.id != authID }) {
            self.authImage.fetchImage(user.image, .ic_placeholder)
            self.authNameLabel.text = user.name
            self.messageLabel.text = object.lastMessage
            self.timeLabel.text = object.sentDate?._timeAgoDisplay
        } else {

        }
    }

    override func didselect(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let authID = UserController().fetchUser()?.id, let object = object as? Conversation, let user = object.users.first(where: { $0.id != authID }) else { return }
        let vc = ChatViewController(otherUser: user)
        vc.conversationID = object.id
        vc._push()
    }

}
