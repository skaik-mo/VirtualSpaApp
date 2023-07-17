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
        self.categoryImage.image = .demo
        if let object = object as? String {
            self.categoryLabel.text = object
            if let _topVC = _topVC as? HomeUserViewController {
                self.isSelectedCell = _topVC.selectedSubCategories == object
            }
        } else {
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
