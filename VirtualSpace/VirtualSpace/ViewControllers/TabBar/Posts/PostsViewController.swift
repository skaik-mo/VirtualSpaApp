// _________SKAIK_MO_________
//  
//  PostsViewController.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 16/07/2023.
//

import UIKit

class PostsViewController: UIViewController {

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

// MARK: - Configurations
private extension PostsViewController {

    func setUpView() {
        self.setUpNavigation()
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        self.tableView.cell = PostTableViewCell.self
        self.tableView.rowHeight = 330
        self.tableView.isPullToRefreshEnable = true
        self.tableView.isLoadMoreEnable = true
        self.tableView.emptyTitle = Strings.POST_EMPTY_TITLE
    }

    func setUpNavigation() {
        self.navigationItem.title = Strings.SOCIAL_MEDIA_POSTS_TITLE
    }

    func fetchData() {
        self.tableView.resetTableView(request: .GetPosts)
    }

}
