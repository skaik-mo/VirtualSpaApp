// _________SKAIK_MO_________
//
//  AcceptedUserViewController.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 13/07/2023.
//

import UIKit

class AcceptedUserViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var authImage: rImage!
    @IBOutlet weak var authNameLabel: UILabel!
    @IBOutlet weak var authEmailLabel: UILabel!
    @IBOutlet weak var messageButton: UIButton!
    @IBOutlet weak var callButton: UIButton!

    // MARK: Properties
    private var reservationUser: UserModel
    private var reservationUserID: String
    private var reservationUserName: String
    private var reservationUserImage: String
    private var reservationUserEmail: String
    private var reservationUserPhone: String
    private var reservationUserCoverImage: String

    // MARK: Init
    init(reservationUserID: String, reservationUserName: String, reservationUserEmail: String, reservationUserPhone: String, reservationUserImage: String, reservationUserCoverImage: String) {
        self.reservationUser = .init(id: reservationUserID, email: reservationUserEmail, name: reservationUserName, phone: reservationUserPhone, image: reservationUserImage, coverImage: reservationUserCoverImage, type: .User)
        self.reservationUserID = reservationUserID
        self.reservationUserName = reservationUserName
        self.reservationUserEmail = reservationUserEmail
        self.reservationUserPhone = reservationUserPhone
        self.reservationUserImage = reservationUserImage
        self.reservationUserCoverImage = reservationUserCoverImage
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
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

}

// MARK: - Actions
private extension AcceptedUserViewController {

    @IBAction func callAction(_ sender: Any) {
        debugPrint(#function)
        Helper.call(reservationUserPhone)
    }

    @IBAction func messageAction(_ sender: Any) {
        debugPrint(#function)
        self._dismissVC()
        let vc = ChatViewController(otherUser: reservationUser)
        vc._push()
    }
}

// MARK: - Configurations
private extension AcceptedUserViewController {

    func setUpView() {
        self.messageButton.applyButtonStyle(.OutlinedPurple(35))
    }

    func setUpData() {
        self.messageButton.titleLabel?.text = Strings.MESSAGE_TITLE
        self.backgroundImage.fetchImage(reservationUserCoverImage, .ic_placeholder)
        self.authImage.fetchImage(reservationUserImage, .ic_placeholder2)
        self.authNameLabel.text = reservationUserName
        self.authEmailLabel.text = reservationUserEmail
    }

}
