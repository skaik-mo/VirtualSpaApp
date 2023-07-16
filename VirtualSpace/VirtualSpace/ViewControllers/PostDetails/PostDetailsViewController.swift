//_________SKAIK_MO_________
//
//  PostDetailsViewController.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 16/07/2023.
//

import UIKit

class PostDetailsViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!

    // MARK: Properties
    var objects: [String: Any] = [
        "Post": 1,
        "Comment_Title": 2,
        "Comments": [
            "Relaxation is a natural state that can be achieved through a variety of methods",
            "Nature can be particularly beneficial for relaxation as it has a calming effect on the mind and body.",
            "Nature can be particularly beneficial for relaxation as it has a calming effect on the mind and body.Nature can be particularly beneficial for relaxation as it has a calming effect on the mind and body.",
            "Nature can be particularly beneficial for relaxation as it has a calming effect on the mind and body.Nature can be particularly beneficial for relaxation as it has a calming effect on the mind and body.Nature can be particularly beneficial for relaxation as it has a calming effect on the mind and body.Nature can be particularly beneficial for relaxation as it has a calming effect on the mind and body.",
            "Relaxation is a natural state that can be achieved through a variety of methods",
            "Relaxation is a natural state that can be achieved through a variety of methods",
            "Relaxation is a natural state that can be achieved through a variety of methods",
            "End",
        ]
    ]

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
private extension PostDetailsViewController {

}


// MARK: - Configurations
private extension PostDetailsViewController {

    func setUpView() {
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        self.tableView._registerCell = PostTableViewCell.self
        self.tableView._registerCell = LabelTableViewCell.self
        self.tableView._registerCell = CommentTableViewCell.self
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }

    func setUpData() {
        self.title = Strings.POSTS_DETAILS_TITLE

    }

    func fetchData() {

    }

}

extension PostDetailsViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        objects.keys.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        section == 2 ? ((self.objects["Comments"] as? [String])?.count ?? 0) : 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell: PostTableViewCell = tableView._dequeueReusableCell()
            cell.lineView.alpha = 0
//            cell.object = object[indexPath.row]
            cell.configureCell()
            return cell
        } else if indexPath.section == 1 {
            let cell: LabelTableViewCell = tableView._dequeueReusableCell()
            cell.configureCell()
            return cell
        }
        let cell: CommentTableViewCell = tableView._dequeueReusableCell()
        cell.object = (objects["Comments"] as? [String])?[indexPath.row]
        cell.configureCell()
        return cell
    }

}
