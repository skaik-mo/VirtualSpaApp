// _________SKAIK_MO_________
//
//  CallTableViewCell.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 13/07/2023.
//

import UIKit

class CallTableViewCell: GeneralTableViewCell {

    @IBOutlet weak var authImage: rImage!
    @IBOutlet weak var authName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func configureCell() {
        if let object = object as? UserModel {
            self.authImage.fetchImage(object.image, .ic_placeholder)
            self.authName.text = object.name
        } else {
            self.authImage.image = nil
            self.authName.text = nil
        }
    }

    @IBAction func callAction(_ sender: Any) {
        guard let object = object as? UserModel, let phone = object.phone else { return }
        debugPrint(#function)
        Helper.call(phone)
    }

    override func didselect(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = TherapistViewController()
        vc._push()
    }
}
