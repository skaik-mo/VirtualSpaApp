// _________SKAIK_MO_________
//
//  CommentTableViewCell.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 16/07/2023.
//

import UIKit

class CommentTableViewCell: GeneralTableViewCell {

    @IBOutlet weak var authImage: UIImageView!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var commentTimeLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func configureCell() {
        if let object = object as? Comment {
            authImage.fetchImage(object.userImage, .ic_placeholder)
            commentLabel.text = object.description
            commentTimeLabel.text = object.createdAt?._timeAgoDisplay
        } else {
            authImage.image = nil
            commentLabel.text = nil
            commentTimeLabel.text = nil
        }
    }

}
