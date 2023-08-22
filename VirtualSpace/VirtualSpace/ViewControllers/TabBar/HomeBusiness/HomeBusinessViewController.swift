// _________SKAIK_MO_________
//
//  HomeBusinessViewController.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 16/07/2023.
//

import UIKit

class HomeBusinessViewController: UIViewController {

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
        self.tabBarController?.tabBar.isHidden = false
    }

}

// MARK: - Actions
private extension HomeBusinessViewController {

    @objc func addPost() {
        debugPrint(#function)
        let vc = NewPostViewController()
        vc.handleBack = { [weak self] post in
            self?.tableView.objects.insert(post, at: 0)
            self?.tableView.setEmptyData()
        }
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .custom
        self._presentVC(vc)
    }
}

// MARK: - Configurations
private extension HomeBusinessViewController {
    func setUpView() {
        self.setUpNavigationItem()
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        self.tableView.cell = PostTableViewCell.self
        self.tableView.rowHeight = 330
        self.tableView.isPullToRefreshEnable = true
        self.tableView.isLoadMoreEnable = true
        self.tableView.emptyTitle = Strings.POST_EMPTY_TITLE
    }

    func setUpNavigationItem() {
        self.navigationItem.titleView = UIImageView.init(image: .ic_virtualSpace)
        let addButton = UIBarButtonItem(image: .ic_add, style: .plain, target: self, action: #selector(addPost))
        self.navigationItem.rightBarButtonItems = [addButton]
    }

    func fetchData() {
        self.tableView.resetTableView(request: .GetPosts)
    }

}
