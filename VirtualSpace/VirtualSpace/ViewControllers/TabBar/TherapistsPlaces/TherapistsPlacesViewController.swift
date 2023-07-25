// _________SKAIK_MO_________
//  
//  TherapistsPlacesViewController.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 12/07/2023.
//

import UIKit

class TherapistsPlacesViewController: UIViewController {

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
private extension TherapistsPlacesViewController {

    func setUpView() {
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        self.tableView.cell = PlaceTableViewCell.self
        self.tableView.rowHeight = 85
        self.tableView.isLoadMoreEnable = true
        self.tableView.isPullToRefreshEnable = true
        self.tableView.emptyTitle = Strings.THERAPISTS_PLACES_EMPTY_TITLE
    }

    func fetchData() {
        self.tableView.resetTableView(request: .GetPlaces)
    }

}

// MARK: - set Up Navigation
extension TherapistsPlacesViewController {
    func getUpNavigationItem() -> UINavigationItem {
        return UINavigationItem(title: Strings.THERAPISTS_PLACES_TITLE)
    }
}
