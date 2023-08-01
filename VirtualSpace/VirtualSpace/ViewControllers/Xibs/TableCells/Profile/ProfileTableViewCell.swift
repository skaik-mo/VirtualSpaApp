// _________SKAIK_MO_________
//
//  ProfileTableViewCell.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 11/07/2023.
//

import UIKit

class ProfileTableViewCell: GeneralTableViewCell {

    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func configureCell() {
        if let object = object as? GlobalConstants.ProfileMenu {
            self.titleLabel.text = object.title
        } else {
            self.titleLabel.text = nil
        }
    }

    override func didselect(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let object = object as? GlobalConstants.ProfileMenu else { return }
        object.action()
    }

}
