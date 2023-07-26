// _________SKAIK_MO_________
//
//  TherapistHeaderTableViewCell.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 18/07/2023.
//

import UIKit

class TherapistHeaderTableViewCell: GeneralTableViewHeaderFooterView {

    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var TherapistImage: rImage!
    @IBOutlet weak var TherapistNameLabel: UILabel!
    @IBOutlet weak var TherapistEmailLabel: UILabel!
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var messageButton: UIButton!
    @IBOutlet weak var bookNowButton: UIButton!
    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var postsButton: UIButton!
    @IBOutlet weak var infoButton: UIButton!

    static var isInfoSelected = false

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func configureHeader() {
        self.customizeButtons()
        self.followButton.titleLabel?.text = Strings.FOLLOW_TITLE
        self.messageButton.titleLabel?.text = Strings.MESSAGE_TITLE
        self.bookNowButton.titleLabel?.text = Strings.BOOK_NOW_TITLE
        self.followButton.applyButtonStyle(.Primary(40))
        self.messageButton.applyButtonStyle(.OutlinedPurple(40))
        self.bookNowButton.applyButtonStyle(.SecondaryLightPurple(40))
        if let object = object as? UserModel {
            self.backgroundImage.fetchImage(object.coverImage, .ic_placeholder)
            self.TherapistImage.fetchImage(object.image, .ic_placeholder)
            self.TherapistNameLabel.text = object.name
            self.TherapistEmailLabel.text = object.email
        } else {
            self.backgroundImage.image = nil
            self.TherapistImage.image = nil
            self.TherapistNameLabel.text = nil
            self.TherapistEmailLabel.text = nil
        }
    }

    private func customizeButtons() {
        switch Self.isInfoSelected {
        case true:
            self.postsButton.setTitleColor(.color_9B9B9B, for: .normal)
            self.infoButton.setTitleColor(.color_000000, for: .normal)
            self.infoButton.layer.addBorder(edge: .bottom, color: .color_000000, thickness: 2)
            self.postsButton.layer.sublayers?.filter { $0 is CAShapeLayer }.forEach { $0.removeFromSuperlayer() }
        case false:
            self.postsButton.setTitleColor(.color_000000, for: .normal)
            self.infoButton.setTitleColor(.color_9B9B9B, for: .normal)
            self.postsButton.layer.addBorder(edge: .bottom, color: .color_000000, thickness: 2)
            self.infoButton.layer.sublayers?.filter { $0 is CAShapeLayer }.forEach { $0.removeFromSuperlayer() }
        }
    }

    @IBAction func followAction(_ sender: Any) {
        debugPrint(#function)
    }

    @IBAction func messageAction(_ sender: Any) {
        debugPrint(#function)
        let vc = ChatViewController()
        vc._push()
    }

    @IBAction func bookNowAction(_ sender: Any) {
        guard let object = object as? UserModel else { return }
        let vc = BookNowViewController(therapist: object)
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .custom
        vc._presentVC()
    }

    @IBAction func callAction(_ sender: Any) {
        guard let object = object as? UserModel, let phone = object.phone else { return }
        debugPrint(#function)
        Helper.call(phone)
    }

    @IBAction func postAction(_ sender: Any) {
        Self.isInfoSelected = false
        if let topVC = self._topVC as? TherapistViewController {
            topVC.isInfoSelected = Self.isInfoSelected
            topVC.fetchData()
        }
    }

    @IBAction func infoAction(_ sender: Any) {
        Self.isInfoSelected = true
        if let topVC = self._topVC as? TherapistViewController {
            topVC.isInfoSelected = Self.isInfoSelected
            topVC.fetchData()
        }
    }

}
