// _________SKAIK_MO_________
//
//  FavoriteViewController.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 12/07/2023.
//

import UIKit

class FavoriteViewController: UIViewController {

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
        fetchData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

}

// MARK: - Configurations
private extension FavoriteViewController {

    func setUpView() {
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        self.tableView.cell = PlaceTableViewCell.self
        self.tableView.rowHeight = 85
        self.tableView.isLoadMoreEnable = true
        self.tableView.isPullToRefreshEnable = true
        self.tableView.emptyTitle = Strings.FAVORITE_EMPTY_TITLE
    }

    func fetchData() {
        self.tableView.resetTableView(request: .GetFavoritePlaces)
    }
}

// MARK: - set Up Navigation
extension FavoriteViewController {
    func getUpNavigationItem() -> UINavigationItem {
        return UINavigationItem(title: Strings.FAVORITE_TITLE)
    }
}
