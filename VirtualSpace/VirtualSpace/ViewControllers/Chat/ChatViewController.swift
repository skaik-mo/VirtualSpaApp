// _________SKAIK_MO_________
//
//  ChatViewController.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 16/07/2023.
//

import UIKit
import MessageKit
import InputBarAccessoryView
import IQKeyboardManagerSwift

class ChatViewController: MessagesViewController {

    // MARK: Outlets

    // MARK: Properties
    lazy var inputBar = {
        let inputBar = TextViewInputBar()
        inputBar.placeholder = Strings.WRITE_PLACEHOLDER
        return inputBar
    }()
    let messageController = MessageController()
    let conversationController = ConversationController()
    var messages: [MessageType] = []
    var conversationID: String?
    var currentUser: UserModel? = UserController().fetchUser()
    var otherUser: UserModel
    var otherSender: Sender {
        return Sender(senderId: otherUser.id ?? "", displayName: otherUser.name ?? "")
    }
    var authSender: Sender {
        return Sender(senderId: currentUser?.id ?? "", displayName: currentUser?.name ?? "")
    }

    // MARK: Init
    init(otherUser: UserModel) {
        self.otherUser = otherUser
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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
        IQKeyboardManager.shared.enable = false
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        IQKeyboardManager.shared.enable = true
        messageController.removeListener()
    }

    override var canBecomeFirstResponder: Bool {
        return true
    }

    override var inputAccessoryView: UIView? {
        return inputBar
    }
}

// MARK: - Actions
private extension ChatViewController {

}

// MARK: - Configurations
private extension ChatViewController {

    func setUpView() {
        self.messagesCollectionView.contentInset = .init(top: 10, left: 0, bottom: 0, right: 0)
        self.messagesCollectionView.messagesDataSource = self
        self.messagesCollectionView.messagesLayoutDelegate = self
        self.messagesCollectionView.messagesDisplayDelegate = self
        self.messagesCollectionView._registerHeader = ChatDateHeader.self
        self.messagesCollectionView.keyboardDismissMode = .onDrag
        self.messagesCollectionView.showsHorizontalScrollIndicator = false
        self.messagesCollectionView.showsVerticalScrollIndicator = false
        self.showMessageTimestampOnSwipeLeft = true
        self.messageInputBar.isHidden = true
        self.inputBar.delegate = self
    }

    func setUpData() {
        self.title = otherUser.name
    }

    func fetchData() {
        self.setConversation(getConversationID: { conversationID in
            _ = self.messageController.getMessages(conversationID: conversationID) { messages in
                self.messages = messages
            }.handlerDidFinishRequest(handler: {
                DispatchQueue.main.async {
                    self.messagesCollectionView.reloadData()
                    self.messagesCollectionView.scrollToLastItem(animated: true)
                }
            })
        })
    }

    private func setConversation(getConversationID: @escaping (_ conversationID: String) -> Void) {
        if let conversationID {
            getConversationID(conversationID)
        } else {
            _ = ConversationController().getConversation(otherUser: self.otherUser, isShowLoader: false) { object in
                if let id = object.id {
                    self.conversationID = id
                    getConversationID(id)
                }
            }
        }
    }

    func isFirstMessageOfDay(_ section: Int) -> Bool {
        if section == 0 {
            return true
        }
        let previousMessage = self.messages[section - 1]
        let currentMessage = self.messages[section]
        return !Calendar.current.isDate(currentMessage.sentDate, inSameDayAs: previousMessage.sentDate)
    }

    func sendMessage(conversation: Conversation, message: Message) {
        _ = ConversationController().addConversation(conversation: conversation) {
            _ = self.messageController.addMessage(message: message) {
                debugPrint("message added")
                self.sendNotification()
            }
        }
    }

    func sendNotification() {
        guard let sender = currentUser, let senderName = sender.name, let conversationID else { return }
        let notification = Notification.init(
            sender: authSender.senderId,
            recipient: otherSender.senderId,
            type: .message,
            title: Strings.NEW_MESSAGE_TITLE,
            body: Strings.NEW_MESSAGE_BODY.replacingOccurrences(of: "{senderName}", with: senderName),
            image: sender.image,
            data: ["conversationID": conversationID, "sender": sender.getDictionary()])
        NotificationController().sendNotification(notification: notification, isShowLoader: false)
    }

}

// MARK: - MessagesDataSource
extension ChatViewController: MessagesDataSource {
    var currentSender: MessageKit.SenderType {
        authSender
    }

    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        messages[indexPath.section]
    }

    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        messages.count
    }

    func messageTimestampLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        NSAttributedString(string: message.sentDate._stringTime, attributes: [NSAttributedString.Key.font: UIFont.poppinsRegular12, NSAttributedString.Key.foregroundColor: UIColor.color_7A7A7A])
    }

}

// MARK: - MessagesLayoutDelegate
extension ChatViewController: MessagesLayoutDelegate {

    func messageHeaderView(for indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageReusableView {
        let headerView: ChatDateHeader = messagesCollectionView._dequeueReusableHeaderView(withClass: ChatDateHeader.self, for: indexPath)
        if Calendar.current.isDateInToday(messages[indexPath.section].sentDate) {
            headerView.configure(date: Strings.TODAY_TITLE)
        } else if Calendar.current.isDateInYesterday(messages[indexPath.section].sentDate) {
            headerView.configure(date: Strings.YESTERDAY_TITLE)
        } else {
            let text = MessageKitDateFormatter.shared.string(from: messages[indexPath.section].sentDate)
            headerView.configure(date: text)
        }
        return headerView
    }

    func headerViewSize(for section: Int, in messagesCollectionView: MessagesCollectionView) -> CGSize {
        return self.isFirstMessageOfDay(section) ? CGSize(width: messagesCollectionView.frame.width, height: 25) : .zero
    }

    public func avatarSize(for message: MessageType, at _: IndexPath, in _: MessagesCollectionView) -> CGSize? {
        return self.isFromCurrentSender(message: message) ? .zero : .init(width: 44, height: 44)
    }

}

// MARK: - MessagesDisplayDelegate
extension ChatViewController: MessagesDisplayDelegate {

    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        if self.isFromCurrentSender(message: message) {
            avatarView.isHidden = true
            avatarView.image = nil
        } else {
            avatarView.fetchImage(otherUser.image, .ic_placeholder)
            avatarView.isHidden = false
        }

    }

    func messageStyle(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageStyle {
        return .custom { view in
            view.cornerRadius = 10
            let mask = self.view._roundCorners(isTopLeft: true, isTopRight: true, isBottomLeft: self.isFromCurrentSender(message: message), isBottomRight: !self.isFromCurrentSender(message: message))
            view.layer.maskedCorners = mask
        }
    }

    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return self.isFromCurrentSender(message: message) ? .color_8C4EFF: .color_F9F9FC
    }

    func textColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return self.isFromCurrentSender(message: message) ? .color_FFFFFF: .color_000000
    }
}

extension ChatViewController: InputBarAccessoryViewDelegate {

    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        guard let conversationID, let currentUser else { return }
        let newMessage = text._removeWhiteSpace
        let conversation = Conversation(id: conversationID, userIDs: [self.authSender.senderId, self.otherSender.senderId], users: [currentUser, otherUser], lastMessage: newMessage)
        let message = Message(conversationID: conversationID, sender: self.authSender, kind: .text(newMessage))
        messages.append(message)
        inputBar.inputTextView.text = ""
        DispatchQueue.main.async {
            self.messagesCollectionView.reloadData()
            self.messagesCollectionView.scrollToLastItem(animated: true)
        }
        self.sendMessage(conversation: conversation, message: message)
    }

}
