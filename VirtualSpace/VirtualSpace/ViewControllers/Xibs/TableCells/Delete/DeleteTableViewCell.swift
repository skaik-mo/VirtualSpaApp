// _________SKAIK_MO_________
//
//  DeleteTableViewCell.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 11/07/2023.
//

import UIKit

class DeleteTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    var object: Any?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }

    func configureCell() {
        if let object = object as? String {
            self.titleLabel.text = object
        } else {
            self.titleLabel.text = nil
        }
    }
}
