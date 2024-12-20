// _________SKAIK_MO_________
//
//  PostHeaderViewTableViewCell.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 26/07/2023.
//

import UIKit

class PostHeaderViewTableViewCell: GeneralTableViewHeaderFooterView {

    @IBOutlet weak var authImage: rImage!
    @IBOutlet weak var authNameLabel: UILabel!
    @IBOutlet weak var postTimeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var commentsLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func configureHeader() {
        let imageGesture = UITapGestureRecognizer(target: self, action: #selector(showImage))
        self.postImage.addGestureRecognizer(imageGesture)
        self.postImage.isUserInteractionEnabled = true
        if let object = object as? Post {
            self.commentsLabel.text = Strings.COMMENTS_TITLE
            self.authImage.fetchImage(object.userImage, .ic_placeholder)
            self.authNameLabel.text = object.userName
            self.postTimeLabel.text = object.modifiedAt?._timeAgoDisplay
            self.descriptionLabel.text = object.description
            self.postImage.fetchImage(object.image, .ic_placeholder)
            self.likeButton.isSelected = object.isFavorite
            self.likeButton.isHidden = false
            self.commentButton.isHidden = false
            self.moreButton.isHidden = false
        } else {
            self.commentsLabel.text = nil
            self.authImage.image = nil
            self.authNameLabel.text = nil
            self.postTimeLabel.text = nil
            self.descriptionLabel.text = nil
            self.postImage.image = nil
            self.likeButton.isHidden = true
            self.commentButton.isHidden = true
            self.moreButton.isHidden = true
        }
    }

    @IBAction func moreAction(_ sender: Any) {
        guard let post = object as? Post, let _topVC = _topVC as? PostDetailsViewController else { return }
        PostController().optionPost(post: post) {
            _topVC._pop()
            _topVC.completionDelete?(post)
        }
    }

    @IBAction func likeAction(_ sender: Any) {
        debugPrint(#function)
        guard let object = object as? Post, let _topVC = _topVC as? PostDetailsViewController else { return }
        self.likeButton.isSelected.toggle()
        object.isFavorite = self.likeButton.isSelected
        PostController().addFivoraitePost(post: object)
        _topVC.handleFavorite?(object)
    }

    @IBAction func commentAction(_ sender: Any) {
        debugPrint(#function)
        guard let _topVC = _topVC as? PostDetailsViewController else { return }
        _topVC.inputText.inputTextView.becomeFirstResponder()

    }

    @IBAction func shareAction(_ sender: Any) {
        debugPrint(#function)
        self._topVC?._showAlertOK(message: "not working")
    }

    @objc private func showImage() {
        let vc = ZoomViewController(imageSelected: self.postImage.image)
        vc.modalPresentationStyle = .custom
        vc.modalTransitionStyle = .crossDissolve
        vc._presentVC()
    }

}
