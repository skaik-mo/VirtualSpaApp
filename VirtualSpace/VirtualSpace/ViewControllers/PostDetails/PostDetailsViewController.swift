//_________SKAIK_MO_________
//
//  PostDetailsViewController.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 16/07/2023.
//

import UIKit
import InputBarAccessoryView

class PostDetailsViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!

    // MARK: Properties
    var objects: [String: Any] = [
        "Post": 1,
        "Comment_Title": 2,
    ]
    var comments: [String] = [
        "Relaxation is a natural state that can be achieved through a variety of methods",
        "Nature can be particularly beneficial for relaxation as it has a calming effect on the mind and body.",
        "Nature can be particularly beneficial for relaxation as it has a calming effect on the mind and body.Nature can be particularly beneficial for relaxation as it has a calming effect on the mind and body.",
        "Nature can be particularly beneficial for relaxation as it has a calming effect on the mind and body.Nature can be particularly beneficial for relaxation as it has a calming effect on the mind and body.Nature can be particularly beneficial for relaxation as it has a calming effect on the mind and body.Nature can be particularly beneficial for relaxation as it has a calming effect on the mind and body.",
        "Relaxation is a natural state that can be achieved through a variety of methods",
        "Relaxation is a natural state that can be achieved through a variety of methods",
        "Relaxation is a natural state that can be achieved through a variety of methods",
        "End",
    ]
    lazy var inputText: TextViewInputBar = {
        let height: CGFloat = 90
        let y = self.view.frame.height - height
        let frame = CGRect.init(x: 0, y: y, width: self.view.frame.width, height: height)
        let inputBar = TextViewInputBar(frame: frame)
        inputBar.delegate = self
        inputBar.placeholder = "Add a comment"
        inputBar.backgroundColor = .red
        return inputBar
    }()

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
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
        self.tableView._registerCell = PostTableViewCell.self
        self.tableView._registerCell = LabelTableViewCell.self
        self.tableView._registerCell = CommentTableViewCell.self
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.view.addSubview(inputText)
    }

    func setUpData() {
        self.title = Strings.POSTS_DETAILS_TITLE

        self.objects["Comments"] = comments


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
            cell.descriptionLabel.numberOfLines = 0
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

extension PostDetailsViewController: InputBarAccessoryViewDelegate {

    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        comments.append(text)
        objects["Comments"] = comments
        self.tableView.reloadData()
        inputBar.inputTextView.text = ""
    }

}
