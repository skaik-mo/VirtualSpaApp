// _________SKAIK_MO_________
//
//  TherapistInfoViewController.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 16/07/2023.
//

import UIKit
import XLPagerTabStrip

class TherapistInfoViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!

    // MARK: Properties
    var object: [String] = ["Title1", "Title2", "Title3", "Title4", "Title5", "Title6", "Title7"]

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

extension TherapistInfoViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: XLPagerTabStrip.PagerTabStripViewController) -> XLPagerTabStrip.IndicatorInfo {
        return IndicatorInfo(title: Strings.INFO_TITLE)
    }
}

// MARK: - Configurations
private extension TherapistInfoViewController {

    func setUpView() {
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        self.tableView._registerHeaderAndFooter = TherapistInfoHeaderTableViewCell.self
        self.tableView.sectionHeaderHeight = UITableView.automaticDimension
        self.tableView._registerCell = PlaceTableViewCell.self
        self.tableView.rowHeight = 85
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }

    func setUpData() {

    }

    func fetchData() {

    }

}

extension TherapistInfoViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        object.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PlaceTableViewCell = tableView._dequeueReusableCell()
        cell.object = object[indexPath.row]
        cell.configureCell()
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = PlaceInfoViewController()
        vc.title = object[indexPath.row]
        vc._push()
    }

    // MARK: - Header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: TherapistInfoHeaderTableViewCell._id) as? TherapistInfoHeaderTableViewCell {
            header.configureHeader()
            return header
        }
        return tableView.tableHeaderView
    }

}
