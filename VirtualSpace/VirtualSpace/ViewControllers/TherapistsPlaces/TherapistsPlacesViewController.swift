//_________SKAIK_MO_________
//  
//  TherapistsPlacesViewController.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 12/07/2023.
//

import UIKit

class TherapistsPlacesViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties
    var object: [String] = ["Title1","Title2","Title3","Title4","Title5","Title6","Title7"]

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
private extension TherapistsPlacesViewController {

    func setUpView() {
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
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

// MARK: - set Up Navigation
extension TherapistsPlacesViewController {
    func getUpNavigationItem() -> UINavigationItem {
        return UINavigationItem(title: Strings.THERAPISTS_PLACES_TITLE)
    }
}

extension TherapistsPlacesViewController: UITableViewDataSource, UITableViewDelegate {
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
}
