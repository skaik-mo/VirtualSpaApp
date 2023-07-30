// _________SKAIK_MO_________
//
//  NotificationTableViewCell.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 12/07/2023.
//

import UIKit

class NotificationTableViewCell: GeneralTableViewCell {

    @IBOutlet weak var notifyImage: rImage!
    @IBOutlet weak var notifyTtitleLabel: UILabel!
    @IBOutlet weak var notifyDateLabel: UILabel!
    @IBOutlet weak var notifyDescrition: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func configureCell() {
        if let object = object as? Notification {
            self.notifyImage.fetchImage(object.image, .ic_placeholder)
            self.notifyTtitleLabel.text = object.title
            self.notifyDescrition.text = object.body
            self.notifyDateLabel.text = object.createdAt?._timeAgoDisplay
        } else {
            self.notifyImage.image = nil
            self.notifyTtitleLabel.text = nil
            self.notifyDescrition.text = nil
            self.notifyDateLabel.text = nil
        }
    }

}
