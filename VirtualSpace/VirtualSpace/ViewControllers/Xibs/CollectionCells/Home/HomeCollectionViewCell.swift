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

    var object: Place?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell() {
        if let object {
            self.placeImage.fetchImage(object.images.first, .ic_placeholder)
            self.placeNameLabel.text = object.name
            self.placeAddressLabel.text = object.address
            self.likeButton.isSelected = object.isFavorite
            var time = ""
            var distance = ""
            if let _distance = object.distance {
                distance = "\(_distance) im"
            }
            if let _time = object.time {
                time = "\(_time) min"
            }
            self.PlaceDistanceLabel.text = "\(time) . \(distance)"
        }

    }

    private func setFavorite() {
        guard let object else { return }
        object.isFavorite = self.likeButton.isSelected
        PlaceController().addFivoraitePlace(place: object)
        if let topVC = self._topVC as? HomeUserViewController {
            if let index = topVC.placesFilters.firstIndex(where: { $0.id == object.id }) {
                topVC.placesFilters[index] = object
            }
        }
    }

    @IBAction func likeAction(_ sender: Any) {
        self.likeButton.isSelected.toggle()
        self.setFavorite()
    }

}
