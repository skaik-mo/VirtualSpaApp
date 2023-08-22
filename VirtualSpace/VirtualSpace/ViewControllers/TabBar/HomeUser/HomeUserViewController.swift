// _________SKAIK_MO_________
//
//  HomeUserViewController.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 17/07/2023.
//

import UIKit
import CoreLocation

class HomeUserViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var subCategoryCollectionView: UICollectionView!
    @IBOutlet weak var homeCollectionView: UICollectionView!
    @IBOutlet weak var lineView: UIView! // line under categoryCollectionView

    // MARK: Properties
    private var locationManger = CLLocationManager()
    private var categories: [Category] = []
    private var subCategories: [SubCategory] = []
    private var places: [Place] = []
    private let spacing: CGFloat = 10 // minimum Spacing For homeCollectionView
    var placesFilters: [Place] = []
    var selectedCategories: Category?
    var selectedSubCategories: SubCategory?
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
        fetchData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        guard let navigationController = self.navigationController as? MainNavigationController else { return }
        navigationController.backgroundColor = .color_FFFFFF
        navigationController.shadowColor = .clear
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard let navigationController = self.navigationController as? MainNavigationController else { return }
        navigationController.shadowColor = .color_A3A3A3
    }

}

// MARK: - Actions
private extension HomeUserViewController {

    @objc func notificationAction() {
        let vc = NotificationViewController()
        self._push(vc)
    }
}

// MARK: - Configurations
private extension HomeUserViewController {

    func setUpView() {
        self.setUpNavigationItem()
        self.locationManger.delegate = self

        self.categoryCollectionView.dataSource = self
        self.categoryCollectionView.delegate = self
        self.categoryCollectionView._registerCell = PagerCollectionViewCell.self
        self.categoryCollectionView.keyboardDismissMode = .onDrag
        self.categoryCollectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
        self.subCategoryCollectionView.dataSource = self
        self.subCategoryCollectionView.delegate = self
        self.subCategoryCollectionView.keyboardDismissMode = .onDrag
        self.subCategoryCollectionView._registerCell = CategoryCollectionViewCell.self
        self.subCategoryCollectionView.contentInset = .init(top: 5, left: 16, bottom: 5, right: 16)
        self.homeCollectionView.dataSource = self
        self.homeCollectionView.delegate = self
        self.homeCollectionView.keyboardDismissMode = .onDrag
        self.homeCollectionView._registerCell = HomeCollectionViewCell.self
        self.homeCollectionView.contentInset = .init(top: 5, left: 16, bottom: 20, right: 16)
    }

    func setUpNavigationItem() {
        self.navigationItem.titleView = self.searchBar
        let notification = UIBarButtonItem(image: .ic_notification_ciracl, style: .plain, target: self, action: #selector(notificationAction))
        self.navigationItem.rightBarButtonItem = notification
    }

    func reloadHomeCollection() {
        self.homeCollectionView.reloadData()
        self.homeCollectionView.emptyDataSet(title: Strings.NO_RESULTS_TITLE)
    }

    func fetchData() {
        self.lineView.isHidden = true
        Helper.showLoader(isLoding: true)
        _ = CategoryController().getCategories(isShowLoader: false) { categories in
            self.categories = categories
            self.selectedCategories = self.categories.first
            _ = SubCategoryController().getSubCategories(isShowLoader: false) { subCategories in
                self.subCategories = subCategories
                self.selectedSubCategories = self.subCategories.first
                _ = PlaceController().getPlaces(isShowLoader: false, success: { places in
                    self.places = places
                    self.setPlacesFilters()
                }).handlerDidFinishRequest(handler: {
                    self.reloadHomeCollection()
                    Helper.showLoader(isLoding: false)
                }).handlerofflineLoad(handler: {
                    self.reloadHomeCollection()
                    Helper.showLoader(isLoding: false)
                })
            }.handlerDidFinishRequest(handler: {
                self.subCategoryCollectionView.reloadData()
            }).handlerofflineLoad(handler: {
                self.subCategoryCollectionView.reloadData()
                Helper.showLoader(isLoding: false)
            })
        }.handlerDidFinishRequest(handler: {
            self.categoryCollectionView.reloadData()
            self.lineView.isHidden = false
        }).handlerofflineLoad(handler: {
            self.categoryCollectionView.reloadData()
            Helper.showLoader(isLoding: false)
        })
    }

    func setPlacesFilters() {
        self.placesFilters = places.filter({ $0.categories.contains(self.selectedCategories?.id ?? "") && $0.subCategories.contains(self.selectedSubCategories?.id ?? "") })
    }

    func searchPlaces(_ text: String?) {
        if let text, text._isValidValue {
            self.placesFilters = places.filter({ $0.name?.contains(text) ?? false })
        } else {
            setPlacesFilters()
        }
        self.reloadHomeCollection()
    }

}

extension HomeUserViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchPlaces(searchText)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchPlaces(searchBar.text)
        searchBar.endEditing(true)
    }
}

extension HomeUserViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == categoryCollectionView {
            return self.categories.count
        } else if collectionView == subCategoryCollectionView {
            return self.subCategories.count
        }
        return self.placesFilters.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == categoryCollectionView {
            let cell: PagerCollectionViewCell = collectionView._dequeueReusableCell(for: indexPath)
            cell.object = self.categories[indexPath.row]
            cell.isSelectedCell = selectedCategories?.id == self.categories[indexPath.row].id
            cell.configureCell()
            return cell
        } else if collectionView == subCategoryCollectionView {
            let cell: CategoryCollectionViewCell = collectionView._dequeueReusableCell(for: indexPath)
            cell.object = self.subCategories[indexPath.row]
            cell.isSelectedCell = selectedSubCategories?.id == self.subCategories[indexPath.row].id
            cell.configureCell()
            return cell
        }
        let cell: HomeCollectionViewCell = collectionView._dequeueReusableCell(for: indexPath)
        cell.object = self.placesFilters[indexPath.row]
        cell.configureCell()
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoryCollectionView {
            self.selectedCategories = self.categories[indexPath.row]
            self.setPlacesFilters()
            collectionView.reloadData()
            self.reloadHomeCollection()
        } else if collectionView == subCategoryCollectionView {
            self.selectedSubCategories = self.subCategories[indexPath.row]
            self.setPlacesFilters()
            collectionView.reloadData()
            self.reloadHomeCollection()
        } else {
            let vc = PlaceDetailsViewController(place: self.placesFilters[indexPath.row])
            vc.handleBack = { [weak self] place in
                if let index = self?.placesFilters.firstIndex(where: { $0.id == place.id }) {
                    self?.placesFilters[index] = place
                    self?.reloadHomeCollection()
                }
            }
            self._push(vc)
        }
    }

}

extension HomeUserViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == categoryCollectionView {
            return 0
        } else if collectionView == subCategoryCollectionView {
            return 12
        }
        return spacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        18
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == categoryCollectionView {
            let width: CGFloat = (self.categories[indexPath.row].name?.size(withAttributes: [.font: UIFont.poppinsMedium14]).width ?? 0) + 18
            return .init(width: width, height: 30)

        } else if collectionView == subCategoryCollectionView {
            let labelWidth: CGFloat = self.subCategories[indexPath.row].name?.size(withAttributes: [.font: UIFont.poppinsMedium14]).width ?? 0
            let imageWidth: CGFloat = 35
            let spacing: CGFloat = 10 * 3
            let width: CGFloat = labelWidth + imageWidth + spacing
            return .init(width: width, height: 50)
        }

        let width: CGFloat = (homeCollectionView.frame.width - homeCollectionView.contentInset.left - homeCollectionView.contentInset.right - spacing) / 2
        return .init(width: width, height: 220)
    }
}

extension HomeUserViewController: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first, let user = UserController().fetchUser() {
            user.coordinate = CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            UserController().setUser(user: user, isShowLoader: false, isShowMessage: false)
        }
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            manager.startUpdatingLocation()
        case .notDetermined:
            debugPrint("notDetermined")
            locationManger.requestWhenInUseAuthorization()
        case .restricted, .denied:
            debugPrint("denied Or restricted location authorization")
            self.showAlertIfDeniedOrRestricted()
        @unknown default:
            debugPrint("unknown")
        }
    }

    private func showAlertIfDeniedOrRestricted() {
        self._showAlert(title: Strings.DETERMINE_LOCATION_TITLE, message: Strings.LOCATION_PRIVACY_SETTINGS_MESSAGE, buttonAction1: {
            self._pop()
            guard let urlGeneral = URL(string: UIApplication.openSettingsURLString) else { return }
            UIApplication.shared.open(urlGeneral)
        })
    }
}
