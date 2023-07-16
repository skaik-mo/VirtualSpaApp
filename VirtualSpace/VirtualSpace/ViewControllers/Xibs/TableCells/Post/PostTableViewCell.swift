//_________SKAIK_MO_________
//
//  PostTableViewCell.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 16/07/2023.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var authImage: rImage!
    @IBOutlet weak var authNameLabel: UILabel!
    @IBOutlet weak var postTimeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var lineView: UIView!

    var object: Any?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }

    func configureCell() {
        let imageGesture = UITapGestureRecognizer(target: self, action: #selector(showImage))
        self.postImage.addGestureRecognizer(imageGesture)
        self.postImage.isUserInteractionEnabled = true
        self.authImage.image = .demo
        self.authNameLabel.text = "Mohammed skaik"
        self.postTimeLabel.text = Date()._timeAgoDisplay
        self.descriptionLabel.text = "It's important to prioritize self-care and relaxation in order to maintain good mental and physical health, It's important to prioritize self-care and relaxation in order to maintain good mental and physical health"
        self.postImage.image = .demo
    }

    @IBAction func moreAction(_ sender: Any) {
        debugPrint(#function)
    }

    @IBAction func likeAction(_ sender: Any) {
        debugPrint(#function)
        self.likeButton.isSelected.toggle()
    }

    @IBAction func commentAction(_ sender: Any) {
        debugPrint(#function)
    }

    @IBAction func shareAction(_ sender: Any) {
        debugPrint(#function)
    }

    @objc private func showImage() {
        let vc = ZoomViewController()
        vc.imageSelected = self.postImage.image
        vc.modalPresentationStyle = .custom
        vc.modalTransitionStyle = .crossDissolve
        vc._presentVC()
    }

}
