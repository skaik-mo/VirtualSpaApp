// _________SKAIK_MO_________
//
//  FriendTableViewCell.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 12/07/2023.
//

import UIKit

class FriendTableViewCell: GeneralTableViewCell {

    @IBOutlet weak var authImage: rImage!
    @IBOutlet weak var authNameLabel: UILabel!
    @IBOutlet weak var friendButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func configureCell() {
        if let object = object as? Friend, let authID = UserController().fetchUser()?.id, let user = object.users.first(where: { $0.id ?? "" != authID }) {
            self.authImage.fetchImage(user.image, .ic_placeholder)
            self.authNameLabel.text = user.name
        } else {
            self.authImage.image = nil
            self.authNameLabel.text = nil
        }
        self.friendButton.titleLabel?.text = Strings.UNFRIEND_TITLE
        self.friendButton.applyButtonStyle(.SecondaryLightPurple())
    }

    @IBAction func unfriendAction(_ sender: Any) {
        guard let friendID = (object as? Friend)?.id, let _topVC = _topVC as? FriendsViewController, let index = _topVC.tableView.objects.firstIndex(where: { ($0 as? Friend)?.id == friendID }) else { return }
        _topVC.tableView.objects.remove(at: index)
        _ = FriendController().deleteFriend(friendID: friendID) { }
    }

    override func didselect(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let object = object as? Friend, let authID = UserController().fetchUser()?.id, let user = object.users.first(where: { $0.id != authID }) else { return }
        let vc = UserDetailsViewController(user: user, friend: object)
        vc._push()
    }

}
