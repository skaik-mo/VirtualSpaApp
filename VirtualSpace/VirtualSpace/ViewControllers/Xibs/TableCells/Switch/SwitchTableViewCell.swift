// _________SKAIK_MO_________
//
//  SwitchTableViewCell.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 11/07/2023.
//

import UIKit

class SwitchTableViewCell: GeneralTableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var accountPrivacySwitch: UISwitch!

    let userController = UserController()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func configureCell() {
        self.setUpSwitch()
        if let object = object as? GlobalConstants.ProfileMenu {
            self.titleLabel.text = object.title
            self.setValue()
        } else {
            self.titleLabel.text = nil
        }
        accountPrivacySwitch.addTarget(self, action: #selector(savePrivacy), for: .valueChanged)
    }

    private func setValue() {
        guard let isPrivate = userController.fetchUser()?.isPrivate else { return }
        self.accountPrivacySwitch.setOn(isPrivate, animated: false)
    }

    private func setUpSwitch() {
        self.accountPrivacySwitch.setScale(0.8, 0.8)
        self.accountPrivacySwitch.setScaleThumb(0.7, 0.7)
    }

    @objc private func savePrivacy() {
        userController.setPrivacy(isPrivate: self.accountPrivacySwitch.isOn)
    }

}
