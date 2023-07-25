// _________SKAIK_MO_________
//
//  TherapistViewController.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 16/07/2023.
//

import UIKit

class TherapistViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!

    // MARK: Properties
    var posts: [Any] = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
    var places: [Any] = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
    var isInfoSelected = false

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

// MARK: - Actions
private extension TherapistViewController {

}

// MARK: - Configurations
private extension TherapistViewController {

    func setUpView() {
        TherapistHeaderTableViewCell.isInfoSelected = false
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: -20, right: 0)
        self.tableView._registerHeaderAndFooter = TherapistHeaderTableViewCell.self
        self.tableView.sectionHeaderHeight = 335
        self.tableView._registerCell = TherapistInfoTableViewCell.self
        self.tableView._registerCell = PlaceTableViewCell.self
        self.tableView._registerCell = PostTableViewCell.self
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }

    func setUpData() {
        self.title = Strings.MESSAGE_THERAPIST_TITLE
    }

    func fetchData() {

    }

}

extension TherapistViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isInfoSelected ? self.places.count + 1 : self.posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isInfoSelected {
            if indexPath.row == 0 {
                let cell: TherapistInfoTableViewCell = tableView._dequeueReusableCell()
//                cell.object = ""
                cell.configureCell()
                return cell
            }
            let cell: PlaceTableViewCell = tableView._dequeueReusableCell()
//            cell.object = object[indexPath.row]
            cell.configureCell()
            return cell
        }
        let cell: PostTableViewCell = tableView._dequeueReusableCell()
//        cell.object = object[indexPath.row]
        cell.configureCell()
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.item == 0 {
            return self.isInfoSelected ? UITableView.automaticDimension : 330
        }
        return self.isInfoSelected ? 85 : 330

    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isInfoSelected {
            guard indexPath.item != 0 else { return }
//            let vc = PlaceInfoViewController()
//            vc.title = object[indexPath.row]
//            vc._push()
            return
        }
        let vc = PostDetailsViewController()
        vc._push()
    }

    // MARK: Header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header: TherapistHeaderTableViewCell = tableView._dequeueReusableHeaderFooterView()
        header.headerOject = ""
        header.configureHeader()
        return header
    }

}
