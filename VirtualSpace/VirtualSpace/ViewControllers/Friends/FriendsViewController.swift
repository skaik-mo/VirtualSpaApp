// _________SKAIK_MO_________
//
//  FriendsViewController.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 12/07/2023.
//

import UIKit

class FriendsViewController: UIViewController {

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
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
    }

}

// MARK: - Configurations
private extension FriendsViewController {

    func setUpView() {
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 15, right: 0)
        self.tableView.isLoadMoreEnable = true
        self.tableView.isPullToRefreshEnable = true
        self.tableView.emptyTitle = Strings.FRIENDS_EMPTY_TITLE
        self.tableView.cell = FriendTableViewCell.self
        self.tableView.rowHeight = 70
    }

    func setUpData() {
        self.title = Strings.MY_FRIENDS_TITLE
    }

    func fetchData() {
        self.tableView.resetTableView(request: .GetFriends)
    }

}
