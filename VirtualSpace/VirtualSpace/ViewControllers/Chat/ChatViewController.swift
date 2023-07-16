//_________SKAIK_MO_________
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
    let inputBar = {
        let inputBar = TextViewInputBar()
        inputBar.placeholder = "Write a message"
        return inputBar
    }()
    var messages: [MessageType] = []
    var otherUser: Sender {
        return Sender(senderId: "2", displayName: "User")
    }
    var currentUser: Sender {
        return Sender(senderId: "1", displayName: "Mohamed")
    }

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
        IQKeyboardManager.shared.enable = false
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        IQKeyboardManager.shared.enable = true
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
        self.messagesCollectionView.contentInset = .init(top: 0, left: 0, bottom: 0, right: 0)
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
        self.title = "auth Name"
        self.messages.append(Message(sender: currentUser, messageId: "1", sentDate: Date()._add(days: -4) ?? Date(), kind: .text("ddddd"), toId: otherUser.senderId))
        self.messages.append(Message(sender: otherUser, messageId: "1", sentDate: Date()._add(days: -3) ?? Date(), kind: .text("message1\nsdcsdcscs\nsdcsdcsdcsdcsdcsdcsdcscsdcsdcsdcsdcsdcsdcsdcscd"), toId: currentUser.senderId))
        self.messages.append(Message(sender: currentUser, messageId: "1", sentDate: Date()._add(days: -1) ?? Date(), kind: .text("message2\nmmmmmmmmmm"), toId: otherUser.senderId))
        self.messages.append(Message(sender: otherUser, messageId: "1", sentDate: Date(), kind: .text("message3"), toId: currentUser.senderId))
        self.messages.append(Message(sender: currentUser, messageId: "1", sentDate: Date(), kind: .text("message4"), toId: otherUser.senderId))
        self.messages.append(Message(sender: currentUser, messageId: "1", sentDate: Date(), kind: .text("message4"), toId: otherUser.senderId))
        self.messages.append(Message(sender: currentUser, messageId: "1", sentDate: Date(), kind: .text("message4"), toId: otherUser.senderId))
        self.messages.append(Message(sender: currentUser, messageId: "1", sentDate: Date(), kind: .text("message4"), toId: otherUser.senderId))
        self.messages.append(Message(sender: currentUser, messageId: "1", sentDate: Date(), kind: .text("message4"), toId: otherUser.senderId))
        self.messages.append(Message(sender: currentUser, messageId: "1", sentDate: Date(), kind: .text("message4"), toId: otherUser.senderId))
        self.messages.append(Message(sender: currentUser, messageId: "1", sentDate: Date(), kind: .text("message4"), toId: otherUser.senderId))
        self.messages.append(Message(sender: currentUser, messageId: "1", sentDate: Date(), kind: .text("message4"), toId: otherUser.senderId))
        DispatchQueue.main.async {
            self.messagesCollectionView.reloadData()
            self.messagesCollectionView.scrollToLastItem(animated: true)
        }
    }

    func fetchData() {

    }

    func isFirstMessageOfDay(_ section: Int) -> Bool {
        if section == 0 {
            return true
        }
        let previousMessage = self.messages[section - 1]
        let currentMessage = self.messages[section]
        return !Calendar.current.isDate(currentMessage.sentDate, inSameDayAs: previousMessage.sentDate)
    }

}

// MARK: - MessagesDataSource
extension ChatViewController: MessagesDataSource {
    var currentSender: MessageKit.SenderType {
        currentUser
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
            let text = MessageKitDateFormatter.shared.string (from: messages[indexPath.section].sentDate)
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
            avatarView.image = otherUser.image
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
        let message = Message(sender: currentUser, messageId: UUID().uuidString, sentDate: Date(), kind: .text(text._removeWhiteSpace), toId: otherUser.senderId)
        messages.append(message)
        inputBar.inputTextView.text = ""
        DispatchQueue.main.async {
            self.messagesCollectionView.reloadData()
            self.messagesCollectionView.scrollToLastItem(animated: true)
        }
    }

}