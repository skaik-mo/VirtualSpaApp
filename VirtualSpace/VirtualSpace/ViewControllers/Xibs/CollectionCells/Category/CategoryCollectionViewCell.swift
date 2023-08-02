// _________SKAIK_MO_________
//
//  CategoryCollectionViewCell.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 17/07/2023.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var superStack: rStack!
    @IBOutlet weak var categoryImage: rImage!
    @IBOutlet weak var categoryLabel: UILabel!

    var object: SubCategory?
    private var isSelectedCell = false {
        didSet {
            self.setCell()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell() {
        if let object {
            self.categoryImage.fetchImage(object.image, .ic_placeholder)
            self.categoryLabel.text = object.name
            if let _topVC = SceneDelegate.shared?.rootNavigationController?.topViewController as? MainTabBarController, let presnt = _topVC.selectedViewController as? HomeUserViewController {
                self.isSelectedCell = presnt.selectedSubCategories?.id == object.id
            }
        } else {
            self.categoryImage.image = nil
            self.categoryLabel.text = nil
        }
    }

    func setCell() {
        switch self.isSelectedCell {
        case true:
            self.superStack.backgroundColor = .color_8C4EFF
            self.categoryLabel.textColor = .color_FFFFFF
        case false:
            self.superStack.backgroundColor = .color_F2F2F2
            self.categoryLabel.textColor = .color_000000
        }
    }

}
