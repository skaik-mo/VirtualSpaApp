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

    override func layoutSubviews() {
        super.layoutSubviews()
        let height = self.inputTextView.frame.height
        inputTextView.cornerRadius = (height == 0 ? 37.0 : height) / 2
    }

    func configure() {
        sendButton.image = .ic_send
        sendButton.setTitle("", for: .normal)
        inputTextView.textContainerInset = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        inputTextView.placeholderLabelInsets = UIEdgeInsets(top: 8, left: 20, bottom: 8, right: 20)
        inputTextView.borderColor = .color_E9E9E9
        inputTextView.borderWidth = 1.0
        inputTextView.backgroundColor = .color_F9FAFF
        inputTextView.font = .poppinsRegular14
        inputTextView.placeholderTextColor = .color_7A7A7A
        inputTextView.textColor = .color_000000
    }

}
