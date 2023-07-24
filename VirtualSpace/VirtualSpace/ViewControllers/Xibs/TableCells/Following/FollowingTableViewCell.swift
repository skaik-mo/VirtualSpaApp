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

    var last: DocumentSnapshot?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }

    override func configureCell() {
        self.followingButton.titleLabel?.text = Strings.FOLLOWING_TITLE
        self.followingButton.applyButtonStyle(.SecondaryLightPurple(35))
        if let object = object as? [String: String] {
            self.authNameLabel.text = object["title"]
        }
    }

    override func didselect(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}
