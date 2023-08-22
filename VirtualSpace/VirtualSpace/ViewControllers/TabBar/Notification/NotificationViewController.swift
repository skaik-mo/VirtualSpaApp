// _________SKAIK_MO_________
//
//  NotificationViewController.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 12/07/2023.
//

import UIKit

class NotificationViewController: UIViewController {

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

        if let navigationController = self.tabBarController?.viewControllers?[2] as? MainNavigationController, navigationController.viewControllers.last == self {
            self.tabBarController?.tabBar.isHidden = false
        }
    }

}

// MARK: - Configurations
private extension NotificationViewController {

    func setUpView() {
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 15, right: 0)
        self.tableView.isPullToRefreshEnable = true
        self.tableView.isLoadMoreEnable = true
        self.tableView.emptyTitle = Strings.NO_NOTIFY_EMPTY_TITLE
        self.tableView.cell = NotificationTableViewCell.self
        self.tableView.rowHeight = UITableView.automaticDimension // 70
    }

    func setUpData() {
        self.navigationItem.title = Strings.NOTIFY_TITLE
    }

    func fetchData() {
        self.tableView.resetTableView(request: .GetNotification)
    }
}
