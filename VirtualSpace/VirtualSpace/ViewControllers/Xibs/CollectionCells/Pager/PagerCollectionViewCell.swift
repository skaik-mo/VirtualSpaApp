// _________SKAIK_MO_________
//
//  PagerCollectionViewCell.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 17/07/2023.
//

import UIKit

class PagerCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ineView: UIView!

    var object: Any?
    var isSelectedCell = false {
        didSet {
            self.setCell()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell() {
        if let object = object as? String {
            self.titleLabel.text = object
            if let _topVC = SceneDelegate.shared?.rootNavigationController?.topViewController as? MainTabBarController, let presnt = _topVC.selectedViewController as? HomeUserViewController {
                self.isSelectedCell = presnt.selectedCategories == object
            }
        } else {
            self.titleLabel.text = nil
        }
    }

    func setCell() {
        switch self.isSelectedCell {
        case true:
            self.titleLabel.textColor = .color_000000
            self.ineView.backgroundColor = .color_000000
        case false:
            self.titleLabel.textColor = .color_9B9B9B
            self.ineView.backgroundColor = .clear
        }
    }

}
