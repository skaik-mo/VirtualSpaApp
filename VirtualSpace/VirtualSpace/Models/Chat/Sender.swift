//
//  Sender.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 16/07/2023.
//

import Foundation
import UIKit
import MessageKit

class Sender: SenderType {
    var senderId: String
    var displayName: String
    var image: UIImage?

    init(senderId: String, displayName: String = "") {
        self.senderId = senderId
        self.displayName = displayName
    }
}
