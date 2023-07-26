// _________SKAIK_MO_________
//
//  AcceptedTableViewCell.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 13/07/2023.
//

import UIKit

class AcceptedTableViewCell: GeneralTableViewCell {

    @IBOutlet weak var authImage: rImage!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func configureCell() {
        if let object = object as? Reservation {
            self.authImage.fetchImage(object.reservationUserImage, .ic_placeholder)
            self.nameLabel.text = object.reservationUserName
            self.dateLabel.text = object.date?._stringDate
        } else {
            self.authImage.image = nil
            self.nameLabel.text = nil
            self.dateLabel.text = nil
        }
    }

    override func didselect(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        guard let object = object as? Reservation, let reservationUser = object.reservationUser else { return }
//        let vc = AcceptedUserViewController(reservationUser: reservationUser)
//        vc.modalTransitionStyle = .crossDissolve
//        vc.modalPresentationStyle = .custom
//        vc._presentVC()
    }
}
