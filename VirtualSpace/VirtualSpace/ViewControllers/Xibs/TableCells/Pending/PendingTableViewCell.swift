// _________SKAIK_MO_________
//
//  PendingTableViewCell.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 13/07/2023.
//

import UIKit

class PendingTableViewCell: UITableViewCell {

    @IBOutlet weak var authImage: rImage!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var rejectButton: UIButton!

    var object: Any?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }

    func configureCell() {
        self.authImage.image = .demo
        self.nameLabel.text = "Name"
        self.dateLabel.text = "13 Jul 2023"
        self.acceptButton.titleLabel?.text = Strings.ACCEPT_TITLE
        self.rejectButton.titleLabel?.text = Strings.REJECT_TITLE
        self.acceptButton.applyButtonStyle(.SecondaryGreen)
        self.rejectButton.applyButtonStyle(.SecondaryRed)
    }

    @IBAction func acceptAction(_ sender: Any) {

    }

    @IBAction func rejectAction(_ sender: Any) {

    }

}
