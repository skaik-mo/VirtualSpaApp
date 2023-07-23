// _________SKAIK_MO_________
//
//  GeneralTableViewCell.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 22/07/2023.
//

import UIKit

class GeneralTableViewCell: UITableViewCell {

    var object: Any?
    var index: Int?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }

    func configureCell() {

    }

    func didselect(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }

}
