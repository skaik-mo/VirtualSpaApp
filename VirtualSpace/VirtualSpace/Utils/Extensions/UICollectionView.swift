//_________SKAIK_MO_________
//
//  UICollectionView.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 09/07/2023.
//

import Foundation
import UIKit

extension UICollectionView {

    // MARK: Register
    var _registerCell: UICollectionViewCell.Type {
        get {
            return UICollectionViewCell.self
        }
        set {
            self.register(UINib.init(nibName: newValue.self._id, bundle: nil), forCellWithReuseIdentifier: newValue.self._id)
        }
    }

    // MARK: Dequeue
    func _dequeueReusableCell<T: UICollectionViewCell>(withClass name: T.Type = T.self, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: name._id, for: indexPath) as? T else {
            fatalError("Couldn't find UICollectionViewCell for \(name._id), make sure the cell is registered with collection view")
         }
         return cell
     }
}
