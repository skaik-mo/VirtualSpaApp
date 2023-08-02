// _________SKAIK_MO_________
//
//  MessageViewController.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 13/07/2023.
//

import UIKit

class MessageViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!

    // MARK: Properties
    private var objects: [Any] = []
    private let emptyTitle = Strings.MESSAGE_EMPTY_TITLE
    private let conversationController = ConversationController()

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
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchData()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        conversationController.removeListener()
    }

}

// MARK: - Configurations
private extension MessageViewController {

    func setUpView() {
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView._registerCell = MassageTableViewCell.self
        self.tableView.rowHeight = 70
    }

    func setUpData() {
        self.title = Strings.MESSAGES_TITLE
    }

    func fetchData() {
        _ = GeneralController.GetConversations.sendRequest(lastDocument: nil, isShowLoader: true) { objects, _, _ in
            self.objects = objects
        }?.handlerDidFinishRequest(handler: {
            self.tableView.reloadData()
            self.tableView.emptyDataSet(headerHeight: nil, image: nil, title: self.emptyTitle, subTitle: "", titleFont: .poppinsMedium17, subTitleFont: .poppinsMedium13)
        }).handlerofflineLoad(handler: {
            self.tableView.reloadData()
            self.tableView.emptyDataSet(headerHeight: nil, image: nil, title: self.emptyTitle, subTitle: "", titleFont: .poppinsMedium17, subTitleFont: .poppinsMedium13)
        })
    }

}

extension MessageViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        objects.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MassageTableViewCell = tableView._dequeueReusableCell()
        cell.object = objects[indexPath.row]
        cell.configureCell()
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? GeneralTableViewCell {
            cell.didselect(tableView, didSelectRowAt: indexPath)
        }
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action: UIContextualAction = UIContextualAction(style: .destructive, title: nil) { (_, _, completionHandler) in
            let conversation = self.objects[indexPath.row] as? Conversation
            self.objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            if let conversation {
                self.conversationController.deleteConversation(conversation: conversation)
            }
            completionHandler(true)
        }
        action.image = .ic_trash
        action.backgroundColor = .color_8C4EFF
        let configuration = UISwipeActionsConfiguration(actions: [action])
        configuration.performsFirstActionWithFullSwipe = true
        return configuration
    }

}
