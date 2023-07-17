// _________SKAIK_MO_________
//
//  NotificationTableViewCell.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 12/07/2023.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {

    @IBOutlet weak var notifyImage: rImage!
    @IBOutlet weak var notifyTtitleLabel: UILabel!
    @IBOutlet weak var notifyDateLabel: UILabel!
    @IBOutlet weak var notifyDescrition: UILabel!

    var object: Any?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }

    func configureCell() {

    }

}
