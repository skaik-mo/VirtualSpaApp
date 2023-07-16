//_________SKAIK_MO_________
//
//  HomeBusinessViewController.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 16/07/2023.
//

import UIKit

class HomeBusinessViewController: UIViewController {

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
        setUpData()
        fetchData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

}

// MARK: - Actions
private extension HomeBusinessViewController {

    @objc func addPost() {
        debugPrint(#function)
    }

}

// MARK: - set Up Navigation
extension HomeBusinessViewController {
    func getUpNavigationItem() -> UINavigationItem {
        let navigationItem = UINavigationItem()
        navigationItem.titleView = UIImageView.init(image: .ic_virtualSpace)
        let addButton = UIBarButtonItem(image: .ic_add, style: .plain, target: self, action: #selector(addPost))
        navigationItem.rightBarButtonItems = [addButton]
        return navigationItem
    }
}

// MARK: - Configurations
private extension HomeBusinessViewController {

    func setUpView() {
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        self.tableView._registerCell = PostTableViewCell.self
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }

    func setUpData() {

    }

    func fetchData() {

    }

}

extension HomeBusinessViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PostTableViewCell = tableView._dequeueReusableCell()
//            cell.object = object[indexPath.row]
        cell.configureCell()
        return cell

    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = PostDetailsViewController()
        vc._push()
    }

}

