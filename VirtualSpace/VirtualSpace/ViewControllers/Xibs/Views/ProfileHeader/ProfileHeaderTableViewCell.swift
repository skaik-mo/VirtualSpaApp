// _________SKAIK_MO_________
//
//  ProfileHeaderTableViewCell.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 11/07/2023.
//

import UIKit

class ProfileHeaderTableViewCell: GeneralTableViewHeaderFooterView {
    @IBOutlet weak var coverImageButton: UIButton!
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var authImage: rImage!
    @IBOutlet weak var authNameLabel: UILabel!
    @IBOutlet weak var authEmailLabel: UILabel!

    private var isEnableSave: Bool = true {
        didSet {
            self.coverImageButton.isUserInteractionEnabled = self.isEnableSave
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func configureHeader() {
        let user = UserController().fetchUser()
        self.coverImage.fetchImage(user?.coverImage, .ic_placeholder)
        self.authNameLabel.text = user?.name
        self.authEmailLabel.text = user?.email
        if let image = user?.image {
            self.authImage.fetchImage(image, .ic_placeholder)
        } else {
            self.authImage.image = .ic_placeholder2
        }
    }

    @IBAction func addCoverImageAction(_ sender: Any) {
        Helper.takeImage { image in
            self.coverImage.image = image
            self.editCoverImage(coverImg: image)
        }
    }

    func editCoverImage(coverImg: UIImage) {
        self.isEnableSave = false
        _ = UserController().editCoverImageUser(coverImage: coverImg).handlerDidFinishRequest(handler: {
            self.isEnableSave = true
        }).handlerofflineLoad(handler: {
            self.isEnableSave = true
        })
    }

}
