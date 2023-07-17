// _________SKAIK_MO_________
//
//  InviteTableViewCell.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 12/07/2023.
//

import UIKit

class InviteTableViewCell: UITableViewCell {

    @IBOutlet weak var authImage: rImage!
    @IBOutlet weak var authNameLabel: UILabel!
    @IBOutlet weak var inviteButton: UIButton!

    var object: Any?
    var isInvited = false {
        didSet {
            self.setInviteButton()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }

    func configureCell() {

    }

    private func setInviteButton() {
        switch self.isInvited {
        case true:
            self.inviteButton.titleLabel?.text = Strings.INVITE_TITLE
            self.inviteButton.applyButtonStyle(.OutlinedPurple(35))
        case false:
            self.inviteButton.titleLabel?.text = Strings.ADD_TITLE
            self.inviteButton.applyButtonStyle(.Primary(35))
        }
    }

    @IBAction func inviteAction(_ sender: Any) {
        self.isInvited.toggle()
    }

}
