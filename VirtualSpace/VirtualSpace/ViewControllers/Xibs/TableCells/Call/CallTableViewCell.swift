//_________SKAIK_MO_________
//
//  CallTableViewCell.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 13/07/2023.
//

import UIKit

class CallTableViewCell: UITableViewCell {

    @IBOutlet weak var authImage: rImage!
    @IBOutlet weak var authName: UILabel!

    var object: Any?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }

    func configureCell() {

    }

    @IBAction func callAction(_ sender: Any) {
        debugPrint(#function)
        let authPhone = "+972594122010"
        Helper.call(authPhone)
    }
}
