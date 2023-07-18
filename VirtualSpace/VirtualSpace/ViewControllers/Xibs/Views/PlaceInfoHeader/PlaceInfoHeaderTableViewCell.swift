// _________SKAIK_MO_________
//
//  PlaceInfoHeaderTableViewCell.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 13/07/2023.
//

import UIKit

class PlaceInfoHeaderTableViewCell: UITableViewHeaderFooterView {

    @IBOutlet weak var placeImage: UIImageView!
    @IBOutlet weak var iconImage: rImage!
    @IBOutlet weak var placeNameLabel: UILabel!
    @IBOutlet weak var placeAddressLabel: UILabel!
    @IBOutlet weak var availableTimeLabel: UILabel!
    @IBOutlet weak var descriptionTitleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var messageTherapistsLabel: UILabel!

    var headerOject: Any?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureHeader() {
        placeImage.image = .demo
        iconImage.image = .demo
        placeNameLabel.text = "Place Name"
        placeAddressLabel.text = "Stanley Avenue City, NY 11530"
        availableTimeLabel.text = "10 min . 0.7 im"
        descriptionTitleLabel.text = Strings.DESCRIPTION_TITLE
        descriptionLabel.text = "Massage therapy is considered an alternative means to alleviate pain, stiffness, reduce stress, and promote overall wellness."
        messageTherapistsLabel.text = Strings.MESSAGE_THERAPISTS_TITLE

    }

}
