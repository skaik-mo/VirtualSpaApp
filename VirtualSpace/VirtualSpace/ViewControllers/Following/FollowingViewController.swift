// _________SKAIK_MO_________
//
//  FollowingViewController.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 12/07/2023.
//

import UIKit

class FollowingViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var tableView: GeneralTableView!

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
        setUpView()
        setUpData()
        fetchData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

}

// MARK: - Configurations
private extension FollowingViewController {

    func setUpView() {
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 15, right: 0)
        self.tableView.isLoadMoreEnable = true
        self.tableView.isPullToRefreshEnable = true
        self.tableView.cell = FollowingTableViewCell.self
        self.tableView.rowHeight = 70
    }

    func setUpData() {
        guard let user = UserController().fetchUser() else { return }
        self.title = user.type == .Business ? Strings.FOLLOWERS_TITLE :  Strings.FOLLOWING_TITLE
    }

    func fetchData() {
        guard let user = UserController().fetchUser() else { return }
        let request: GeneralController = user.type == .Business ? .GetFollowing : .GetFollowers
        self.tableView.resetTableView(request: request)
    }

}
