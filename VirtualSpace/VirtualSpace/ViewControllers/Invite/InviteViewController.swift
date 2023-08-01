// _________SKAIK_MO_________
//
//  InviteViewController.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 12/07/2023.
//

import UIKit

class InviteViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var tableView: GeneralTableView!

    // MARK: Properties
    var invitedUserIDs: [String] = []
    var place: Place

    // MARK: Init
    init(place: Place) {
        self.place = place
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
        fetchData(isShowLoader: true)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

}

// MARK: - Configurations
private extension InviteViewController {

    func setUpView() {
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 15, right: 0)
        self.tableView.isPullToRefreshEnable = false
        self.tableView.control.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        self.tableView.refreshControl = self.tableView.control
        self.tableView.cell = InviteTableViewCell.self
        self.tableView.rowHeight = 70
    }

    func setUpData() {
        self.title = Strings.NEARBY_TITLE
    }

    func fetchData(isShowLoader: Bool) {
        _ = FriendController().getFriends(limit: nil, lastDocument: nil, isShowLoader: isShowLoader) { friends, _, _ in
            self.tableView.resetTableView(request: .GetNearbyUsers(friends), isShowLoader: isShowLoader)
        }
    }

    @objc func pullToRefresh() {
        self.fetchData(isShowLoader: false)
    }

}
