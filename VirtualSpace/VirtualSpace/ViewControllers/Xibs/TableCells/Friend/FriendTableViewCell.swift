// _________SKAIK_MO_________
//
//  FriendTableViewCell.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 12/07/2023.
//

import UIKit

class FriendTableViewCell: UITableViewCell {

    @IBOutlet weak var authImage: rImage!
    @IBOutlet weak var authNameLabel: UILabel!
    @IBOutlet weak var friendButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }

    func configureCell() {
        self.friendButton.titleLabel?.text = Strings.UNFRIEND_TITLE
        self.friendButton.applyButtonStyle(.SecondaryLightPurple(35))
    }

}
