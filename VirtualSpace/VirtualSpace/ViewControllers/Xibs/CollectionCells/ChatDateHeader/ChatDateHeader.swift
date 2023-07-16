//
//  ChatDateHeader.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 16/07/2023.
//

import Foundation
import UIKit
import MessageKit

class ChatDateHeader: MessageReusableView {
    private let dateLabel = UILabel()

    override class func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(date: String) {
        dateLabel.textAlignment = .center
        dateLabel.font = .poppinsRegular14
        dateLabel.textColor = .color_000000
        dateLabel.text = date
        addSubview(dateLabel)

        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.topAnchor.constraint(equalTo: topAnchor, constant: 4).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true

    }
}
