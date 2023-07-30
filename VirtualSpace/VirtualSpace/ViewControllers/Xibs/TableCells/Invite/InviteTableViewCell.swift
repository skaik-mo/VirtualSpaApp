// _________SKAIK_MO_________
//
//  InviteTableViewCell.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 12/07/2023.
//

import UIKit

class InviteTableViewCell: GeneralTableViewCell {

    @IBOutlet weak var authImage: rImage!
    @IBOutlet weak var authNameLabel: UILabel!
    @IBOutlet weak var inviteButton: UIButton!
    var isInvited = false {
        didSet {
            self.setInviteButton()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func configureCell() {
        self.isInvited = false
        if let object = object as? UserModel, let id = object.id {
            self.authImage.fetchImage(object.image, .ic_placeholder)
            self.authNameLabel.text = object.name
            if let _topVC = _topVC as? InviteViewController {
                self.isInvited = _topVC.invitedUserIDs.contains(id)
            }
        } else {
            self.authImage.image = nil
            self.authNameLabel.text = nil
        }
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
        guard let id = (object as? UserModel)?.id, let _topVC = _topVC as? InviteViewController else { return }
        self.isInvited = true
        _topVC.invitedUserIDs.append(id)
    }

}
