// _________SKAIK_MO_________
//
//  HomeCollectionViewCell.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 17/07/2023.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var placeImage: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var placeNameLabel: UILabel!
    @IBOutlet weak var placeAddressLabel: UILabel!
    @IBOutlet weak var PlaceDistanceLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell() {
        self.placeImage.image = .demo
        self.placeNameLabel.text = "Hilton Resorts"
        self.placeAddressLabel.text = "MO 63017, United States"
        self.PlaceDistanceLabel.text = "10 min . 0.7 im"

    }

    @IBAction func likeAction(_ sender: Any) {
        self.likeButton.isSelected.toggle()
    }

}
