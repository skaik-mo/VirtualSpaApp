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

    var object: Any?
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
        self.placeImage.image = .demo
        if let object = object as? UIImage {
            self.placeImage.image = object
            if let topVC = self._topVC as? PlaceDetailsViewController {
                self.isSelectedCell = topVC.selectedPlaceImage == object
            }
        }
    }

    private func setBorder() {
        self.placeImage.borderColor = .color_8C4EFF
        self.placeImage.borderWidth = self.isSelectedCell ? 2 : 0
    }

}
