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
    @IBOutlet weak var tableView: UITableView!

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
private extension PlaceInfoViewController {

    func setUpView() {
        self.tableView._registerHeaderAndFooter = PlaceInfoHeaderTableViewCell.self
        self.tableView.sectionHeaderHeight = 365// UITableView.automaticDimension
        self.tableView._registerCell = CallTableViewCell.self
        self.tableView.rowHeight = 60
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }

    func fetchData() {

    }

}

extension PlaceInfoViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        20
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CallTableViewCell = tableView._dequeueReusableCell()
//        cell.object = item.title
        cell.configureCell()
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = TherapistViewController()
        vc._push()
    }

    // MARK: Header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header: PlaceInfoHeaderTableViewCell = tableView._dequeueReusableHeaderFooterView()
        header.headerOject = ""
        header.configureHeader()
        return header
    }

}
