// _________SKAIK_MO_________
//
//  ReservationTableViewCell.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 12/07/2023.
//

import UIKit

class ReservationTableViewCell: GeneralTableViewCell {

    @IBOutlet weak var authImage: rImage!
    @IBOutlet weak var authNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var reservationButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func configureCell() {
        if let object = object as? Reservation {
            self.authImage.fetchImage(object.therapistImage, .ic_placeholder)
            self.authNameLabel.text = object.therapistName
            self.timeLabel.text = object.date?._stringDate
            self.setStatus(object.status)
            self.reservationButton.isHidden = false
        } else {
            self.authImage.image = nil
            self.authNameLabel.text = nil
            self.timeLabel.text = nil
            self.reservationButton.isHidden = true
        }
    }

    private func setStatus(_ status: ReservationStatus) {
        switch status {
        case .Pending:
            self.reservationButton.titleLabel?.text = Strings.PENDING_TITLE
            self.reservationButton.applyButtonStyle(.SecondaryLightGray)
        case .Accept:
            self.reservationButton.titleLabel?.text = Strings.ACCEPTED_TITLE
            self.reservationButton.applyButtonStyle(.SecondaryGreen)
        case .Reject:
            self.reservationButton.titleLabel?.text = Strings.REJECTED_TITLE
            self.reservationButton.applyButtonStyle(.SecondaryRed)
        }
    }

}
