//
//  TherapistHeaderView.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 16/07/2023.
//

import UIKit

class TherapistHeaderView: UIView {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var TherapistImage: rImage!
    @IBOutlet weak var TherapistNameLabel: UILabel!
    @IBOutlet weak var TherapistEmailLabel: UILabel!
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var messageButton: UIButton!
    @IBOutlet weak var bookNowButton: UIButton!
    @IBOutlet weak var callButton: UIButton!

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureXib()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureXib()
    }

    func configureXib() {
        let bundle = Bundle(for: TherapistHeaderView.self)
        contentView = UINib(nibName: TherapistHeaderView._id, bundle: bundle).instantiate(withOwner: self).first as? UIView
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.frame = bounds
        addSubview(contentView)
        setUpView()
    }

    func setUpView() {
        self.backgroundImage.image = .demo
        self.TherapistImage.image = .demo
        self.TherapistNameLabel.text = "Mohammed skiak"
        self.TherapistEmailLabel.text = "mohamedsaeb.skaik@gmail.com"
        self.followButton.titleLabel?.text = Strings.FOLLOW_TITLE
        self.followButton.applyButtonStyle(.Primary(40))
        self.messageButton.titleLabel?.text = Strings.MESSAGE_TITLE
        self.messageButton.applyButtonStyle(.OutlinedPurple(40))
        self.bookNowButton.titleLabel?.text = Strings.BOOK_NOW_TITLE
        self.bookNowButton.applyButtonStyle(.SecondaryLightPurple(40))
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
        debugPrint(#function)
    }

    @IBAction func callAction(_ sender: Any) {
        debugPrint(#function)
        let authPhone = "+972594122010"
        Helper.call(authPhone)
    }



}
