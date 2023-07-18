// _________SKAIK_MO_________
//
//  HomeUserViewController.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 17/07/2023.
//

import UIKit

class HomeUserViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var pagerCollectionView: UICollectionView!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var homeCollectionView: UICollectionView!

    // MARK: Properties
    var categories: [String] = ["cat   1", "cat1", "categories1", "categories   1", "cat   2", "cat2", "categories2", "categories   2", "cat   3", "cat3", "categories3", "categories   3"]
    var selectedCategories: String = ""
    var subCategories: [String] = ["subcat   1", "subcat", "Sub Categories3", "Sub Categories   4"]
    var selectedSubCategories: String = ""
    var objjects: [Any] = [1, 1, 1, 11, 11, 1, 1, 1, 1, 1, 1, 1]
    let spacing: CGFloat = 10 // minimum Spacing For homeCollectionView
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 280, height: 0))
        searchBar.delegate = self
        searchBar.searchTextField.font = .poppinsMedium13
        searchBar.searchTextField.textColor = .color_000000
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: Strings.SEARCH_FREIENDS_PLACEHOLDER, attributes: [NSAttributedString.Key.foregroundColor: UIColor.color_7A7A7A])
        return searchBar
    }()

    // MARK: Init
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setUpData()
        fetchData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

}

// MARK: - set Up Navigation
extension HomeUserViewController {
    func getUpNavigationItem() -> UINavigationItem {
        let navigationItem = UINavigationItem()
        navigationItem.titleView = self.searchBar
        let notification = UIBarButtonItem(image: .ic_notification_ciracl, style: .plain, target: self, action: #selector(notificationAction))
        navigationItem.rightBarButtonItems = [notification]
        return navigationItem
    }
}

// MARK: - Actions
private extension HomeUserViewController {

    @objc func notificationAction() {
        let vc = NotificationViewController()
        vc._push()
    }
}

// MARK: - Configurations
private extension HomeUserViewController {

    func setUpView() {
        self.pagerCollectionView.dataSource = self
        self.pagerCollectionView.delegate = self
        self.pagerCollectionView._registerCell = PagerCollectionViewCell.self
        self.pagerCollectionView.keyboardDismissMode = .onDrag
        self.pagerCollectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
        self.categoryCollectionView.dataSource = self
        self.categoryCollectionView.delegate = self
        self.categoryCollectionView.keyboardDismissMode = .onDrag
        self.categoryCollectionView._registerCell = CategoryCollectionViewCell.self
        self.categoryCollectionView.contentInset = .init(top: 5, left: 16, bottom: 5, right: 16)
        self.homeCollectionView.dataSource = self
        self.homeCollectionView.delegate = self
        self.homeCollectionView.keyboardDismissMode = .onDrag
        self.homeCollectionView._registerCell = HomeCollectionViewCell.self
        self.homeCollectionView.contentInset = .init(top: 5, left: 16, bottom: 20, right: 16)
    }

    func setUpData() {
        self.selectedCategories = self.categories.first ?? ""
        self.selectedSubCategories = self.subCategories.first ?? ""
    }

    func fetchData() {

    }

}

extension HomeUserViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}

extension HomeUserViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == pagerCollectionView {
            return self.categories.count
        } else if collectionView == categoryCollectionView {
            return self.subCategories.count
        }
        return self.objjects.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == pagerCollectionView {
            let cell: PagerCollectionViewCell = collectionView._dequeueReusableCell(for: indexPath)
            cell.object = self.categories[indexPath.row]
            cell.configureCell()
            return cell
        } else if collectionView == categoryCollectionView {
            let cell: CategoryCollectionViewCell = collectionView._dequeueReusableCell(for: indexPath)
            cell.object = self.subCategories[indexPath.row]
            cell.configureCell()
            return cell
        }
        let cell: HomeCollectionViewCell = collectionView._dequeueReusableCell(for: indexPath)
//        cell.object = self.subCategories[indexPath.row]
        cell.configureCell()
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == pagerCollectionView {
            self.selectedCategories = self.categories[indexPath.row]
            collectionView.reloadData()
        } else if collectionView == categoryCollectionView {
            self.selectedSubCategories = self.subCategories[indexPath.row]
            collectionView.reloadData()
        } else {
            let vc = PlaceDetailsViewController()
            vc._push()
        }
    }

}

extension HomeUserViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == pagerCollectionView {
            return 0
        } else if collectionView == categoryCollectionView {
            return 12
        }
        return spacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        18
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == pagerCollectionView {
            let width: CGFloat = self.categories[indexPath.row].size(withAttributes: [.font: UIFont.poppinsMedium14]).width + 18
            return .init(width: width, height: 30)

        } else if collectionView == categoryCollectionView {
            let labelWidth: CGFloat = self.subCategories[indexPath.row].size(withAttributes: [.font: UIFont.poppinsMedium14]).width
            let imageWidth: CGFloat = 35
            let spacing: CGFloat = 10 * 3
            let width: CGFloat = labelWidth + imageWidth + spacing
            return .init(width: width, height: 50)
        }

        let width: CGFloat = (homeCollectionView.frame.width - homeCollectionView.contentInset.left - homeCollectionView.contentInset.right - spacing) / 2
        return .init(width: width, height: 220)
    }
}
