//_________SKAIK_MO_________
//
//  CommentTableViewCell.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 16/07/2023.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    @IBOutlet weak var authImage: UIImageView!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var commentTimeLabel: UILabel!

    var object: Any?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }

    func configureCell() {
        authImage.image = .demo
        commentTimeLabel.text = Date()._timeAgoDisplay
        if let object = object as? String {
            commentLabel.text = object
        } else {
            commentLabel.text = nil
        }
    }

}
