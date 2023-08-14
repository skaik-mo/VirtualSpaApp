// _________SKAIK_MO_________
//
//  PostDetailsViewController.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 16/07/2023.
//

import UIKit
import InputBarAccessoryView
import IQKeyboardManagerSwift

class PostDetailsViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var tableView: GeneralTableView!

    // MARK: Properties
    private var post: Post
    private var inpuTextHeight = 60.0
    var completionDelete: ((_ post: Post) -> Void)?
    var handleFavorite: ((_ post: Post) -> Void)?
    lazy var inputText: TextViewInputBar = {
        let inputBar = TextViewInputBar()
        inputBar.delegate = self
        inputBar.placeholder = Strings.ADD_COMMENT_PLACEHOLDER
        return inputBar
    }()

    // MARK: Init
    init(post: Post) {
        self.post = post
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
        IQKeyboardManager.shared.enable = false
        IQKeyboardManager.shared.enableAutoToolbar = false
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardNotification(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = true
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }

}

// MARK: - Actions
private extension PostDetailsViewController {

}

// MARK: - Configurations
private extension PostDetailsViewController {

    func setUpView() {
        self.setUpTableView()
        self.inpuTextHeight += self._getStatusBarHeightBottom ?? 0
        self.view.addSubview(inputText)
        self.inputText.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.inputText.heightAnchor.constraint(equalToConstant: self.inpuTextHeight),
            self.inputText.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            self.inputText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            self.inputText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
            ])
    }

    func setUpData() {
        self.title = Strings.POSTS_DETAILS_TITLE
    }

    func fetchData() {
        self.tableView.resetTableView(request: .GetCommentsForPost(self.post))
    }

    func setUpTableView() {
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
        self.tableView.keyboardDismissMode = .onDrag
        self.tableView.isLoadMoreEnable = true
        self.tableView.isPullToRefreshEnable = true
        self.tableView.emptyTitle = Strings.NO_COMMENTS_EMPTY_TITLE
        self.tableView.emptyHeaderHeight = 300
        self.tableView.header = PostHeaderViewTableViewCell.self
        self.tableView.sectionHeaderHeight = UITableView.automaticDimension
        self.tableView.cell = CommentTableViewCell.self
        self.tableView.rowHeight = UITableView.automaticDimension
    }
}

extension PostDetailsViewController: InputBarAccessoryViewDelegate {

    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        guard let user = UserController().fetchUser(), let userID = user.id, let userImage = user.image else { return }
        let comment = Comment(postID: self.post.id, userID: userID, userImage: userImage, description: text)
        self.tableView.objects.insert(comment, at: 0)
        self.tableView.setEmptyData()
        inputBar.inputTextView.text = ""
        _ = CommentController().setComment(comment: comment)

    }

}
