// _________SKAIK_MO_________
//
//  PlaceInfoHeaderTableViewCell.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 13/07/2023.
//

import UIKit

class PlaceInfoHeaderTableViewCell: GeneralTableViewHeaderFooterView {

    @IBOutlet weak var placeImage: UIImageView!
    @IBOutlet weak var iconImage: rImage!
    @IBOutlet weak var placeNameLabel: UILabel!
    @IBOutlet weak var placeAddressLabel: UILabel!
    @IBOutlet weak var availableTimeLabel: UILabel!
    @IBOutlet weak var descriptionTitleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var messageTherapistsLabel: UILabel!
    @IBOutlet weak var clockImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func configureHeader() {
        if let object = object as? Place {
            self.clockImage.isHidden = false
            self.descriptionTitleLabel.text = Strings.DESCRIPTION_TITLE
            self.messageTherapistsLabel.text = Strings.MESSAGE_THERAPISTS_TITLE
            self.placeImage.fetchImage(object.coverImage, .ic_placeholder)
            self.iconImage.fetchImage(object.icon, .ic_placeholder)
            self.iconImage.isHidden = false
            self.placeNameLabel.text = object.name
            self.placeAddressLabel.text = object.address
            self.availableTimeLabel.text = object.getTimeAndDistance()
            self.descriptionLabel.text = object.description
        } else {
            self.clockImage.isHidden = true
            self.descriptionTitleLabel.text = nil
            self.messageTherapistsLabel.text = nil
            self.placeImage.image = nil
            self.iconImage.isHidden = true
            self.iconImage.image = nil
            self.placeNameLabel.text = nil
            self.placeAddressLabel.text = nil
            self.availableTimeLabel.text = nil
            self.descriptionLabel.text = nil
        }
    }

}
