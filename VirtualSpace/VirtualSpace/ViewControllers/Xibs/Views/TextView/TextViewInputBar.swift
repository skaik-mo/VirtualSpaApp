//
//  TextViewInputBar.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 16/07/2023.
//

import Foundation
import UIKit
import InputBarAccessoryView

final class TextViewInputBar: InputBarAccessoryView {

    var placeholder: String {
        get {
            return inputTextView.placeholder ?? ""
        }
        set {
            self.inputTextView.placeholder = newValue
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure() {
        sendButton.image = .ic_send
        sendButton.setTitle("", for: .normal)
        inputTextView.textContainerInset = UIEdgeInsets(top: 12, left: 16, bottom: 8, right: 16)
        inputTextView.placeholderLabelInsets = UIEdgeInsets(top: 12, left: 20, bottom: 8, right: 20)
        inputTextView.borderColor = .color_E9E9E9
        inputTextView.borderWidth = 1.0
        inputTextView.backgroundColor = .color_F9FAFF
        inputTextView.font = .poppinsRegular13
        inputTextView.placeholderTextColor = .color_7A7A7A
        inputTextView.textColor = .color_000000
        inputTextView.cornerRadius = 23
        NSLayoutConstraint.activate([
            inputTextView.heightAnchor.constraint(equalToConstant: 45)
            ])
        separatorLine.isHidden = true
    }

}
