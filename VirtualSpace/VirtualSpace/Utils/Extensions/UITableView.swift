//_________SKAIK_MO_________
//
//  UITableView.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 09/07/2023.
//

import Foundation
import UIKit

extension UITableView {

    // MARK:  Register Cell
    var _registerCell: UITableViewCell.Type {
        get {
            return UITableViewCell.self
        }
        set {
            self.register(UINib(nibName: newValue.self._id, bundle: nil), forCellReuseIdentifier: newValue.self._id)
        }
    }

    // MARK:  Register Header And Footer
    var _registerHeaderAndFooter: UITableViewHeaderFooterView.Type {
        get {
            return UITableViewHeaderFooterView.self
        }
        set {
            self.register(UINib(nibName: newValue.self._id, bundle: nil), forHeaderFooterViewReuseIdentifier: newValue.self._id)
        }
    }

    // MARK: Dequeue Cell
    func _dequeueReusableCell<T: UITableViewCell>() -> T {
        guard let cell = dequeueReusableCell(withIdentifier: String(describing: T.self)) as? T else {
            fatalError("Could not locate viewcontroller with identifier \((T.self)._id) in storyboard.")
        }
        return cell
    }

    // MARK: Dequeue Header And Footer
    func _dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(withClass name: T.Type = T.self) -> T {
        guard let headerFooterView = dequeueReusableHeaderFooterView(withIdentifier: String(describing: name)) as? T else {
            fatalError("Couldn't find UITableViewHeaderFooterView for \(name._id), make sure the view is registered with table view")
        }
        return headerFooterView
    }

}
