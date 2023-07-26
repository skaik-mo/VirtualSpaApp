// _________SKAIK_MO_________
//
//  FollowingTableViewCell.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 12/07/2023.
//

import UIKit
import FirebaseFirestore

class FollowingTableViewCell: GeneralTableViewCell {

    @IBOutlet weak var authImage: rImage!
    @IBOutlet weak var authNameLabel: UILabel!
    @IBOutlet weak var followingButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func configureCell() {
        if let object = object as? Follow, let user = object.user {
            self.authImage.fetchImage(user.image, .ic_placeholder)
            self.authNameLabel.text = user.name
            self.followingButton.titleLabel?.text = Strings.FOLLOWING_TITLE
        } else {
            self.authImage.image = nil
            self.authNameLabel.text = nil
            self.followingButton.titleLabel?.text = nil
        }
        self.followingButton.applyButtonStyle(.SecondaryLightPurple(35))
    }

    @IBAction func followAction(_ sender: Any) {
        guard let object = object as? Follow, let id = object.id, let _topVC = _topVC as? FollowingViewController, let index = _topVC.tableView.objects.firstIndex(where: { ($0 as? Follow)?.id == object.id }) else { return }
        _ = FollowController().removeFollowing(followID: id, success: {
            _topVC.tableView.objects.remove(at: index)
        })
    }

}
