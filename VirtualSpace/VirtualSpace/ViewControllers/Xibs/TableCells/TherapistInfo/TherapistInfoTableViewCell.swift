// _________SKAIK_MO_________
//
//  TherapistInfoTableViewCell.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 18/07/2023.
//

import UIKit

class TherapistInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var bioTitleLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var workInLabel: UILabel!

//    var headerOject: Any?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }

    func configureCell() {
        self.bioTitleLabel.text = Strings.BIO_TITLE
        self.bioLabel.text = "Ahh, the great things that can happen when you kick off your shoes and give your feet a massage 🙅🏻‍♂️ #massaging."
        self.workInLabel.text = Strings.WORK_IN_TITLE
    }

}
