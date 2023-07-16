//_________SKAIK_MO_________
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

    // MARK: Init
    init() {
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
        let authPhone = "+972594122010"
        Helper.call(authPhone)
    }

    @IBAction func messageAction(_ sender: Any) {
        debugPrint(#function)
        self._dismissVC()
        let vc = ChatViewController()
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
    }

}

