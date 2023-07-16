//_________SKAIK_MO_________
//
//  TherapistInfoHeaderTableViewCell.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 16/07/2023.
//

import UIKit

class TherapistInfoHeaderTableViewCell: UITableViewHeaderFooterView {
    
    @IBOutlet weak var bioTitleLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var workInLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureHeader() {
        self.bioTitleLabel.text = Strings.BIO_TITLE
        self.bioLabel.text = "Ahh, the great things that can happen when you kick off your shoes and give your feet a massage 🙅🏻‍♂️ #massaging."
        self.workInLabel.text = Strings.WORK_IN_TITLE
    }
    
}
