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
    @IBOutlet weak var separatorView: UIView!

    static var isInfoSelected = false
    static var isRefreshView = true
    private let followController = FollowController()
    private var follow: Follow? {
        didSet {
            self.setTitleButtons()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func configureHeader() {
        self.customizeButtons()
        guard Self.isRefreshView else { return }
        if let object = object as? UserModel {
            self.backgroundImage.fetchImage(object.coverImage, .ic_placeholder)
            self.TherapistImage.fetchImage(object.image, .ic_placeholder2)
            self.TherapistNameLabel.text = object.name
            self.TherapistEmailLabel.text = object.email
            self.checkFollow()
            self.postsButton.setTitle(Strings.POSTS_TITLE, for: .normal)
            self.infoButton.setTitle(Strings.INFO_TITLE, for: .normal)
            self.postsButton.isHidden = false
            self.infoButton.isHidden = false
            self.separatorView.isHidden = false
            Self.isRefreshView = false
        } else {
            self.backgroundImage.image = nil
            self.TherapistImage.image = nil
            self.TherapistNameLabel.text = nil
            self.TherapistEmailLabel.text = nil
            self.postsButton.setTitle(nil, for: .normal)
            self.infoButton.setTitle(nil, for: .normal)
            self.followButton.isHidden = true
            self.messageButton.isHidden = true
            self.bookNowButton.isHidden = true
            self.callButton.isHidden = true
            self.postsButton.isHidden = true
            self.infoButton.isHidden = true
            self.separatorView.isHidden = true
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

    private func checkFollow() {
        debugPrint(#function)
        guard let followingUserID = (object as? UserModel)?.id, let followerUserID = UserController().fetchUser()?.id else { return }
        _ = followController.searchFollowing(followerUserID: followerUserID, followingUserID: followingUserID, isShowLoader: false) { follow in
            self.follow = follow
        }
    }

    private func setTitleButtons() {
        debugPrint(#function)
        if follow != nil {
            self.followButton.title = Strings.FOLLOWING_TITLE
            self.followButton.applyButtonStyle(.OutlinedPurple(40))
        } else {
            self.followButton.title = Strings.FOLLOW_TITLE
            self.followButton.applyButtonStyle(.Primary(40))
        }
        self.messageButton.title = Strings.MESSAGE_TITLE
        self.bookNowButton.title = Strings.BOOK_NOW_TITLE
        self.messageButton.applyButtonStyle(.OutlinedPurple(40))
        self.bookNowButton.applyButtonStyle(.SecondaryLightPurple(40))
        self.followButton.isHidden = false
        self.messageButton.isHidden = false
        self.bookNowButton.isHidden = false
        self.callButton.isHidden = false
    }

    func sendNotification() {
        guard let sender = UserController().fetchUser(), let senderId = sender.id, let senderName = sender.name, let recipient = object as? UserModel, let recipientID = recipient.id else { return }
        let notification = Notification.init(
            sender: senderId,
            recipient: recipientID,
            type: .Following,
            title: senderName,
            body: Strings.NEW_FOLLOWER_BODY.replacingOccurrences(of: "{senderName}", with: senderName),
            image: sender.image,
            data: ["sender": sender.getDictionary()])
        NotificationController().sendNotification(notification: notification, isShowLoader: false)
    }

    @IBAction func followAction(_ sender: Any) {
        guard let object = object as? UserModel, let followingUserID = object.id, let followerUserID = UserController().fetchUser()?.id else { return }
        if let follow, let followID = follow.id {
            _ = self.followController.removeFollowing(followID: followID) {
                self.follow = nil
            }
        } else {
            let follow = Follow(followerUserID: followerUserID, followingUserID: followingUserID)
            _ = followController.addFollowing(follow: follow) {
                self.follow = follow
                self.sendNotification()
            }
        }
    }

    @IBAction func messageAction(_ sender: Any) {
        debugPrint(#function)
        guard let therapist = object as? UserModel else { return }
        let vc = ChatViewController(otherUser: therapist)
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
        guard Self.isInfoSelected else { return }
        Self.isInfoSelected = false
        if let topVC = self._topVC as? TherapistViewController {
            topVC.isInfoSelected = Self.isInfoSelected
            topVC.fetchData()
        }
    }

    @IBAction func infoAction(_ sender: Any) {
        guard !Self.isInfoSelected else { return }
        Self.isInfoSelected = true
        if let topVC = self._topVC as? TherapistViewController {
            topVC.isInfoSelected = Self.isInfoSelected
            topVC.fetchData()
        }
    }

}
