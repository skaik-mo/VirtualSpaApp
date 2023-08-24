// _________SKAIK_MO_________
//
//  TherapistInfoTableViewCell.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 18/07/2023.
//

import UIKit

class TherapistInfoTableViewCell: GeneralTableViewCell {

    @IBOutlet weak var bioTitleLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var workInLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func configureCell() {
        self.bioTitleLabel.text = Strings.BIO_TITLE
        self.workInLabel.text = Strings.WORK_IN_TITLE
        if let therapist = object as? UserModel {
            self.bioLabel.text = therapist.bio
        } else {
            self.bioLabel.text = nil
        }
    }

}
