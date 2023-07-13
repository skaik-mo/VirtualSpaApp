//_________SKAIK_MO_________
//
//  AcceptedTableViewCell.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 13/07/2023.
//

import UIKit

class AcceptedTableViewCell: UITableViewCell {

    @IBOutlet weak var authImage: rImage!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

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
    }

}
