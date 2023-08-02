// _________SKAIK_MO_________
//
//  PlaceInfoViewController.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 12/07/2023.
//

import UIKit

class PlaceInfoViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var tableView: GeneralTableView!

    // MARK: Properties
    private var place: Place

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
        setData()
        fetchData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

}

// MARK: - Configurations
private extension PlaceInfoViewController {

    func setUpView() {
        self.tableView.header = PlaceInfoHeaderTableViewCell.self
        self.tableView.sectionHeaderHeight = 360// UITableView.automaticDimension
        self.tableView.cell = CallTableViewCell.self
        self.tableView.rowHeight = 60
        self.tableView.emptyHeaderHeight = 250
        self.tableView.emptyTitle = Strings.THERAPISTS_EMPTY_TITLE
    }

    func setData() {
        self.title = place.name
    }

    func fetchData() {
        self.tableView.resetTableView(request: .GetTherapists(self.place))
    }

}
