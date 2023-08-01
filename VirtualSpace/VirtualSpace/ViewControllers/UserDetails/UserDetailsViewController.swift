// _________SKAIK_MO_________
//
//  UserDetailsViewController.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 01/08/2023.
//

import UIKit

class UserDetailsViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var userImage: rImage!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var friendButton: UIButton!
    @IBOutlet weak var messageButton: UIButton!
    @IBOutlet weak var callButton: UIButton!

    // MARK: Properties
    private let friendController = FriendController()
    private let user: UserModel
    private var friend: Friend?
    var isHidenFriendButton = false

    // MARK: Init
    init(user: UserModel, friend: Friend?) {
        self.user = user
        self.friend = friend
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpData()
        setUpView()
        fetchData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

}

// MARK: - Actions
private extension UserDetailsViewController {

    @IBAction func friendAction(_ sender: Any) {
        if let friend, let friendID = friend.id {
            _ = friendController.deleteFriend(friendID: friendID) {
                self.friend = nil
                self.setCustomizeFriendButton()
            }
        } else {
            guard let userID = user.id, let auth = UserController().fetchUser(), let authID = auth.id else { return }
            let friend = Friend(userIDs: [userID, authID], users: [user, auth])
            _ = friendController.addFriend(friend: friend) {
                self.friend = friend
                self.setCustomizeFriendButton()
                self.sendNotification()
            }
        }
    }

    @IBAction func messageAction(_ sender: Any) {
        debugPrint(#function)
        let vc = ChatViewController(otherUser: user)
        vc._push()
    }

    @IBAction func callAction(_ sender: Any) {
        guard let phone = user.phone else { return }
        debugPrint(#function)
        Helper.call(phone)
    }

}

// MARK: - Configurations
private extension UserDetailsViewController {

    func setUpView() {
        self.friendButton.isHidden = isHidenFriendButton
        self.messageButton.applyButtonStyle(.OutlinedPurple(40))
    }

    func setUpData() {
        self.title = Strings.PROFILE_TITLE
        self.coverImage.fetchImage(user.coverImage, .ic_placeholder)
        self.userImage.fetchImage(user.image, .ic_placeholder2)
        self.userNameLabel.text = user.name
        self.userEmailLabel.text = user.email
        self.messageButton.titleLabel?.text = Strings.MESSAGE_TITLE
    }

    func fetchData() {
        guard !isHidenFriendButton else { return }
        if self.friend == nil {
            checkIsFriend()
        } else {
            self.setCustomizeFriendButton()
        }
    }

}

private extension UserDetailsViewController {

    func sendNotification() {
        guard let sender = UserController().fetchUser(), let senderId = sender.id, let senderName = sender.name, let recipientID = user.id else { return }
        let notification = Notification.init(
            sender: senderId,
            recipient: recipientID,
            type: .Following,
            title: Strings.NEW_FRIEND_TITLE,
            body: Strings.NEW_FRIEND_BODY.replacingOccurrences(of: "{senderName}", with: senderName),
            image: sender.image,
            data: ["sender": sender.getDictionary()])
        NotificationController().sendNotification(notification: notification, isShowLoader: false)
    }

    func checkIsFriend() {
        guard friend == nil else { return }
        _ = friendController.checkFriend(otherUserID: user.id) { friend in
            self.friend = friend
            self.setCustomizeFriendButton()
        }
    }

    func setCustomizeFriendButton() {
        if friend == nil {
            self.friendButton.titleLabel?.text = Strings.ADD_TITLE
            self.friendButton.applyButtonStyle(.Primary(40))
        } else {
            self.friendButton.titleLabel?.text = Strings.UNFRIEND_TITLE
            self.friendButton.applyButtonStyle(.SecondaryLightPurple(40))
        }
    }

}
