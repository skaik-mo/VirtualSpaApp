// _________SKAIK_MO_________
//
//  PlaceImageCollectionViewCell.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 18/07/2023.
//

import UIKit

class PlaceImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var placeImage: UIImageView!

    var object: String?
    private var isSelectedCell = false {
        didSet {
            self.setBorder()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell() {
        if let object {
            self.placeImage.fetchImage(object, .ic_placeholder)
            if let topVC = self._topVC as? PlaceDetailsViewController {
                self.isSelectedCell = topVC.selectedPlaceImageStr == object
            }
        }
    }

    private func setBorder() {
        self.placeImage.borderColor = .color_8C4EFF
        self.placeImage.borderWidth = self.isSelectedCell ? 2 : 0
    }

}
