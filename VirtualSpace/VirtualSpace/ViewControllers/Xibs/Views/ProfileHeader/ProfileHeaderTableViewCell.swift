// _________SKAIK_MO_________
//
//  ProfileHeaderTableViewCell.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 11/07/2023.
//

import UIKit

class ProfileHeaderTableViewCell: UITableViewHeaderFooterView {
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var authImage: rImage!
    @IBOutlet weak var authNameLabel: UILabel!
    @IBOutlet weak var authEmailLabel: UILabel!

    var headerOject: Any?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureHeader() {
        if let headerOject {
            self.backgroundImage.image = .demo
            self.authImage.image = .demo
            self.authNameLabel.text = "Mohammed"
            self.authEmailLabel.text = "m@s.com"
        } else {
            self.backgroundImage.image = nil
            self.authImage.image = nil
            self.authNameLabel.text = nil
            self.authEmailLabel.text = nil
        }
    }

}
