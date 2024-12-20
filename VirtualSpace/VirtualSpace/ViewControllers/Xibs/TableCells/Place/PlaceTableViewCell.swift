// _________SKAIK_MO_________
//
//  PlaceTableViewCell.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 12/07/2023.
//

import UIKit

class PlaceTableViewCell: GeneralTableViewCell {

    @IBOutlet weak var placeImage: UIImageView!
    @IBOutlet weak var placeNameLabel: UILabel!
    @IBOutlet weak var placeAddressLabel: UILabel!
    @IBOutlet weak var availableTimeLabel: UILabel!
    @IBOutlet weak var iconButton: UIButton!

    private var isFavoriteVC = false {
        didSet {
            self.setIconButton()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func configureCell() {
        self.isFavoriteVC = self._topVC is FavoriteViewController
        if let object = object as? Place {
            self.placeImage.fetchImage(object.icon, nil)
            self.placeNameLabel.text = object.name
            self.placeAddressLabel.text = object.address
            self.availableTimeLabel.text = object.getTimeAndDistance()
        } else {
            self.placeImage.image = nil
            self.placeNameLabel.text = nil
            self.placeAddressLabel.text = nil
            self.availableTimeLabel.text = nil
        }
    }

    private func setIconButton() {
        self.iconButton.setImage(isFavoriteVC ? .ic_remove: .ic_circleArrow, for: .normal)
        self.iconButton.isUserInteractionEnabled = isFavoriteVC
    }

    @IBAction func removeAction(_ sender: Any) {
        guard let topVC = self._topVC as? FavoriteViewController, let object = object as? Place, let index = topVC.tableView.objects.firstIndex(where: { ($0 as? Place)?.id == object.id }) else { return }
        topVC.tableView.objects.remove(at: index)
        topVC.tableView.setEmptyData()
        PlaceController().addFivoraitePlace(place: object)
    }

    override func didselect(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let object = object as? Place else { return }
        if let _topVC = self._topVC as? TherapistViewController, _topVC.placeID == object.id {
            _topVC._pop()
        } else {
            let vc = PlaceInfoViewController(place: object)
            vc._push()
        }
    }
}
