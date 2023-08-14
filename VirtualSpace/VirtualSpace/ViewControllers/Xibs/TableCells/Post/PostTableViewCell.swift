// _________SKAIK_MO_________
//
//  PostTableViewCell.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 16/07/2023.
//

import UIKit

class PostTableViewCell: GeneralTableViewCell {

    @IBOutlet weak var authImage: rImage!
    @IBOutlet weak var authNameLabel: UILabel!
    @IBOutlet weak var postTimeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func configureCell() {
        let imageGesture = UITapGestureRecognizer(target: self, action: #selector(showImage))
        self.postImage.addGestureRecognizer(imageGesture)
        self.postImage.isUserInteractionEnabled = true
        if let object = object as? Post {
            self.authImage.fetchImage(object.userImage, .ic_placeholder)
            self.authNameLabel.text = object.userName
            self.postTimeLabel.text = object.modifiedAt?._timeAgoDisplay
            self.descriptionLabel.text = object.description
            self.postImage.fetchImage(object.image, .ic_placeholder)
            self.likeButton.isSelected = object.isFavorite
        } else {
            self.authImage.image = nil
            self.authNameLabel.text = nil
            self.postTimeLabel.text = nil
            self.descriptionLabel.text = nil
            self.postImage.image = nil
        }
    }

    private func reloadTableView(_ postID: String) {
        let _topVC = SceneDelegate.shared?.rootNavigationController?._topMostViewController
        if let _topVC = _topVC as? HomeBusinessViewController, let index = _topVC.tableView.objects.firstIndex(where: { ($0 as? Post)?.id == postID }) {
            _topVC.tableView.objects.remove(at: index)
        } else if let _topVC = _topVC as? PostsViewController, let index = _topVC.tableView.objects.firstIndex(where: { ($0 as? Post)?.id == postID }) {
            _topVC.tableView.objects.remove(at: index)
        } else if let _topVC = _topVC as? TherapistViewController, let index = _topVC.tableView.objects.firstIndex(where: { ($0 as? Post)?.id == postID }) {
            _topVC.tableView.objects.remove(at: index)
        }
    }

    @IBAction func moreAction(_ sender: Any) {
        debugPrint(#function)
        guard let object = self.object as? Post, let postID = object.id else { return }
        PostController().optionPost(post: object) {
            self.reloadTableView(postID)
        }
    }

    @IBAction func likeAction(_ sender: Any) {
        debugPrint(#function)
        guard let object = object as? Post else { return }
        self.likeButton.isSelected.toggle()
        object.isFavorite = self.likeButton.isSelected
        PostController().addFivoraitePost(post: object)
    }

    @IBAction func commentAction(_ sender: Any) {
        self.goToPostDetails()
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

    override func didselect(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.goToPostDetails()
    }

    func goToPostDetails() {
        guard let object = object as? Post else { return }
        let vc = PostDetailsViewController(post: object)
        vc.completionDelete = { [weak self] post in
            guard let postID = post.id else { return }
            self?.reloadTableView(postID)
        }
        vc.handleFavorite = { [weak self] post in
            self?.object = post
            self?.configureCell()
        }
        vc._push()
    }

}
