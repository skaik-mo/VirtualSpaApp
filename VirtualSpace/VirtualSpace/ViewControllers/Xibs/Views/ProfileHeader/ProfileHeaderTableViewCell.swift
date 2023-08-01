// _________SKAIK_MO_________
//
//  ProfileHeaderTableViewCell.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 11/07/2023.
//

import UIKit

class ProfileHeaderTableViewCell: GeneralTableViewHeaderFooterView {
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var authImage: rImage!
    @IBOutlet weak var authNameLabel: UILabel!
    @IBOutlet weak var authEmailLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func configureHeader() {
        let user = UserController().fetchUser()
        self.backgroundImage.fetchImage(user?.coverImage, .ic_placeholder)
        self.authNameLabel.text = user?.name
        self.authEmailLabel.text = user?.email
        if let image = user?.image {
            self.authImage.fetchImage(image, .ic_placeholder)
        } else {
            self.authImage.image = .ic_placeholder2
        }
    }

}
