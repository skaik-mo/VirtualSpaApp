//_________SKAIK_MO_________
//
//  ReservationTableViewCell.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 12/07/2023.
//

import UIKit

class ReservationTableViewCell: UITableViewCell {

    @IBOutlet weak var authImage: rImage!
    @IBOutlet weak var authNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var reservationButton: UIButton!

    var object: Any?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }


    func configureCell() {
        if let object = object as? GlobalConstants.ButtonStyle {
            self.reservationButton.titleLabel?.text = object == .SecondaryGreen ? "Accepted" : "Pending"
            self.reservationButton.applyButtonStyle(object)
        } else {
            self.reservationButton.titleLabel?.text = nil
        }
    }

}
