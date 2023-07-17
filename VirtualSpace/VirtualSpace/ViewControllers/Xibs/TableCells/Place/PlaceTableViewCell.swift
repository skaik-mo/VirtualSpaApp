// _________SKAIK_MO_________
//
//  PlaceTableViewCell.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 12/07/2023.
//

import UIKit

class PlaceTableViewCell: UITableViewCell {

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
    var object: Any?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }

    func configureCell() {
        self.isFavoriteVC = self._topVC is FavoriteViewController
        if let object = object as? String {
            self.placeNameLabel.text = object
        }
    }

    private func setIconButton() {
        self.iconButton.setImage(isFavoriteVC ? .ic_remove: .ic_circleArrow, for: .normal)
        self.iconButton.isUserInteractionEnabled = isFavoriteVC
    }

    @IBAction func removeAction(_ sender: Any) {
        guard let topVC = self._topVC as? FavoriteViewController, let object = object as? String, let index = topVC.object.firstIndex(of: object) else { return }
        topVC.object.remove(at: index)
        topVC.tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .left)
    }
}
