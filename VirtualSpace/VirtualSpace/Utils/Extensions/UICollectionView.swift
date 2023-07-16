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

    var _registerHeader: UICollectionReusableView.Type {
        set {
            self.register(newValue, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: newValue.self._id)
        }
        get {
            return UICollectionReusableView.self
        }
    }

    // MARK: Dequeue
    func _dequeueReusableCell<T: UICollectionViewCell>(withClass name: T.Type = T.self, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: name._id, for: indexPath) as? T else {
            fatalError("Couldn't find UICollectionViewCell for \(name._id), make sure the cell is registered with collection view")
         }
         return cell
     }

    func _dequeueReusableHeaderView<T: UICollectionReusableView>(withClass name: T.Type, for indexPath: IndexPath) -> T {
        guard let header = dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: name._id, for: indexPath) as? T else {
            fatalError("Couldn't find UICollectionReusableView for \(name._id), make sure the cell is registered with collection view")
        }
        return header

    }
}
