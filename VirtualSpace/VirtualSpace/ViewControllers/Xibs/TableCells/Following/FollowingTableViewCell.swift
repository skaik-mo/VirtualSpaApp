//_________SKAIK_MO_________
//
//  FollowingTableViewCell.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 12/07/2023.
//

import UIKit

class FollowingTableViewCell: UITableViewCell {

    @IBOutlet weak var authImage: rImage!
    @IBOutlet weak var authNameLabel: UILabel!
    @IBOutlet weak var followingButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }
    
    func configureCell() {
        self.followingButton.titleLabel?.text = Strings.FOLLOWING_TITLE
        self.followingButton.applyButtonStyle(.SecondaryLightPurple(35))
    }
    
}
