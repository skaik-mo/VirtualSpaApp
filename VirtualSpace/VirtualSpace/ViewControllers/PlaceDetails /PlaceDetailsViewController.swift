// _________SKAIK_MO_________
//
//  PlaceDetailsViewController.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 18/07/2023.
//

import UIKit
import CTPanoramaView

class PlaceDetailsViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var placeImageView: CTPanoramaView!
    @IBOutlet weak var rotationStack: UIStackView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var musicNameLabel: UILabel!
    @IBOutlet weak var zoomButton: UIButton!
    @IBOutlet weak var descriptionStack: UIStackView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var bottomStack: UIStackView!
    @IBOutlet weak var heightCollectionConstraint: NSLayoutConstraint!

    // MARK: Properties
    var objects: [UIImage?] = [.ic_360, .demo, .ic_auth]
    var objectsTemp: [UIImage?] = []
    var height = 90.0 // height for the collection view
    var selectedPlaceImage: UIImage?
    var likeButton: UIBarButtonItem?
    var isLike = false {
        didSet {
            self.likeButton?.image = isLike ? .ic_heartCircleRed: .ic_heartCircle
        }
    }

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
        SceneDelegate.shared?.rootNavigationController?.backgroundColor = .clear
        SceneDelegate.shared?.rootNavigationController?.shadowColor = .clear
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        SceneDelegate.shared?.rootNavigationController?.backgroundColor = .color_FFFFFF
        SceneDelegate.shared?.rootNavigationController?.shadowColor = .color_A3A3A3
    }
}

// MARK: - Actions
private extension PlaceDetailsViewController {

    @IBAction func playAction(_ sender: Any) {
        self.playButton.isSelected.toggle()
    }

    @IBAction func zoomAction(_ sender: Any) {
        self.zoomInOutAnimation()
    }

    @objc func pop() {
        self._pop()
    }

    @objc func inviteAction() {
        let vc = InviteViewController()
        vc._push()
    }

    @objc func likeAction() {
        self.isLike.toggle()
    }

}

// MARK: - Configurations
private extension PlaceDetailsViewController {

    func setUpView() {
        self.heightCollectionConstraint.constant = height
        self.setUpNaicgation()
        self.placeImageView.angleOffset = 180
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView._registerCell = PlaceImageCollectionViewCell.self
        self.collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
    }

    func setUpData() {
        self.objectsTemp = self.objects
        self.selectedPlaceImage = self.objects.first ?? nil
        self.placeImageView.image = self.selectedPlaceImage
        self.placeImageView.panoramaType = .cylindrical
        self.musicNameLabel.text = "Relaxing Jazz Music for Study slkdmlsdmcklsdmcklsdmklm"
        self.descriptionLabel.text = "Take a tour of Club Med Punta Cana - Dominican Republic [360°]"
    }

    func fetchData() {

    }

    func setUpNaicgation() {
        likeButton = UIBarButtonItem(image: .ic_heartCircle, style: .plain, target: self, action: #selector(likeAction))
        likeButton?.setBackgroundImage(.ic_heartCircleRed, for: .selected, barMetrics: .default)
        let inviteButton = UIButton()
        inviteButton.setImage(.ic_invite, for: .normal)
        inviteButton.addTarget(self, action: #selector(inviteAction), for: .touchUpInside)
        let backButton = UIBarButtonItem(image: .ic_backWhite, style: .plain, target: self, action: #selector(self.pop))
        self.navigationItem.rightBarButtonItem = likeButton
        self.navigationItem.titleView = inviteButton
        self.navigationItem.leftBarButtonItem = backButton
    }

    func zoomInOutAnimation() {
        self.zoomButton.isSelected.toggle()
        UIView.animate(withDuration: 0.5) {
            self._isHideNavigation = self.zoomButton.isSelected
            self.rotationStack.isHidden = self.zoomButton.isSelected
            self.descriptionStack.isHidden = self.zoomButton.isSelected
            self.objectsTemp = self.zoomButton.isSelected ? [] : self.objects
            self.collectionView.reloadData()
            self.bottomStack.isLayoutMarginsRelativeArrangement = !self.zoomButton.isSelected
            self.heightCollectionConstraint.constant = self.zoomButton.isSelected ? 0 : self.height
            self.view.layoutIfNeeded()
        }
    }

}

extension PlaceDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.objectsTemp.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PlaceImageCollectionViewCell = collectionView._dequeueReusableCell(for: indexPath)
        cell.object = self.objectsTemp[indexPath.row]
        cell.configureCell()
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedPlaceImage = self.objectsTemp[indexPath.row]
        self.placeImageView.image = self.selectedPlaceImage
        collectionView.reloadData()
    }
}

extension PlaceDetailsViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        13
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 80, height: 80)
    }
}
