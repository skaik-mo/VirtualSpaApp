// _________SKAIK_MO_________
//
//  EmptyDataSet.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 22/07/2023.
//

import UIKit

extension UIScrollView {

    func emptyDataSet(headerHeight: CGFloat? = nil, image: UIImage? = nil, title: String = "", subTitle: String = "", titleFont: UIFont = UIFont.systemFont(ofSize: 20, weight: .regular), subTitleFont: UIFont = UIFont.systemFont(ofSize: 17, weight: .regular)) {

        let view = self.setupView(headerHeight: headerHeight, image: image, title: title, subTitle: subTitle, titleFont: titleFont, subTitleFont: subTitleFont)

        if itemsCount == 0 {
            // TableView
            if let tableView = self as? UITableView {
                if tableView.backgroundView == nil {
                    tableView.backgroundView = view
                }
            }
            // CollectionView
                else if let collectionView = self as? UICollectionView {
                if collectionView.backgroundView == nil {
                    collectionView.backgroundView = view
                }
            }
            // ScrollView
            else {
                self.addSubview(view)
            }
            self.animate(view)

        } else {
            if let tableView = self as? UITableView {
                tableView.backgroundView = nil
            } else if let collectionView = self as? UICollectionView {
                collectionView.backgroundView = nil
            }
        }
    }

    internal var itemsCount: Int {
        var items = 0

        if let tableView = self as? UITableView {
            var sections = 1

            if let dataSource = tableView.dataSource {
                if dataSource.responds(to: #selector(UITableViewDataSource.numberOfSections(in:))) {
                    // swiftlint:disable force_unwrapping
                    sections = dataSource.numberOfSections!(in: tableView)
                }
                if dataSource.responds(to: #selector(UITableViewDataSource.tableView(_: numberOfRowsInSection:))) {
                    for i in 0 ..< sections {
                        items += dataSource.tableView(tableView, numberOfRowsInSection: i)
                    }
                }
            }
        } else if let collectionView = self as? UICollectionView {
            var sections = 1

            if let dataSource = collectionView.dataSource {
                if dataSource.responds(to: #selector(UICollectionViewDataSource.numberOfSections(in:))) {
                    sections = dataSource.numberOfSections!(in: collectionView)
                }
                if dataSource.responds(to: #selector(UICollectionViewDataSource.collectionView(_: numberOfItemsInSection:))) {
                    for i in 0 ..< sections {
                        items += dataSource.collectionView(collectionView, numberOfItemsInSection: i)
                    }
                }
            }
        }
        return items
    }
}

private extension UIScrollView {

    // MARK: Create View
    func setupView(headerHeight: CGFloat?, image: UIImage?, title: String, subTitle: String, titleFont: UIFont, subTitleFont: UIFont) -> UIView {

        // _________Create imageView_________
        let imageStackView = createImage(image)

        // _________Create Title_________
        let title = createTitle(title, titleFont)

        // _________Create SubTitle_________
        let subTite = createSubTitle(subTitle, subTitleFont)

        let titlesStackView = UIStackView()
        titlesStackView.axis = NSLayoutConstraint.Axis.vertical
        titlesStackView.alignment = UIStackView.Alignment.center
        titlesStackView.spacing = 5
        titlesStackView.addArrangedSubview(title)
        titlesStackView.addArrangedSubview(subTite)

        // _________Create Sub StackView_________
        let subStackView = UIStackView()
        subStackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: headerHeight ?? 0, leading: 30, bottom: 0, trailing: 30)
        subStackView.isLayoutMarginsRelativeArrangement = true
        subStackView.axis = NSLayoutConstraint.Axis.vertical
        subStackView.alignment = UIStackView.Alignment.center
        subStackView.spacing = 30
        subStackView.addArrangedSubview(imageStackView)
        subStackView.addArrangedSubview(titlesStackView)

        // _________Create Super StackView_________
        let superStackView = UIStackView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        superStackView.axis = NSLayoutConstraint.Axis.horizontal
        superStackView.alignment = UIStackView.Alignment.center
        superStackView.addArrangedSubview(subStackView)
        return superStackView
    }

    // MARK: Animation
    func animate(_ view: UIView) {
        let animation = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
        animation.fromValue = 0.0
        animation.toValue = 1.0
        animation.duration = 1.0
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        view.layer.add(animation, forKey: "animate")
    }

}

private extension UIScrollView {

    func createImage(_ image: UIImage?) -> UIStackView {
        let imageView = UIImageView.init(image: image)
        let imageStackView = UIStackView()
        imageStackView.axis = NSLayoutConstraint.Axis.horizontal
        imageStackView.alignment = UIStackView.Alignment.center
        imageStackView.addArrangedSubview(imageView)
        return imageStackView
    }

    func createTitle(_ title: String, _ font: UIFont) -> UILabel {
        let label = UILabel()
        label.text = title
        label.font = font
        label.textAlignment = .center
        label.textColor = .darkGray
        label.numberOfLines = 0
        return label
    }

    func createSubTitle(_ subTitle: String, _ font: UIFont) -> UILabel {
        let label = UILabel()
        label.text = subTitle
        label.font = font
        label.textAlignment = .center
        label.textColor = .lightGray
        label.numberOfLines = 0
        return label
    }

}
