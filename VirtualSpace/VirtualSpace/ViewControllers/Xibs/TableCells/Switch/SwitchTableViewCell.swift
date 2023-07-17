// _________SKAIK_MO_________
//
//  SwitchTableViewCell.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 11/07/2023.
//

import UIKit

class SwitchTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var accountPrivacySwitch: UISwitch!
    var object: Any?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }

    func configureCell() {
        self.setUpSwitch()
        if let object = object as? String {
            self.titleLabel.text = object
        } else {
            self.titleLabel.text = nil
        }
    }

    private func setUpSwitch() {
        self.accountPrivacySwitch.setScale(0.8, 0.8)
        self.accountPrivacySwitch.setScaleThumb(0.7, 0.7)
    }

}
