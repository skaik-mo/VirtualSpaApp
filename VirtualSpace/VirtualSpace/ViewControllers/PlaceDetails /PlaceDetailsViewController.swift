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
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var heightCollectionConstraint: NSLayoutConstraint!
    @IBOutlet weak var audioIndicatorView: AudioVisualizationView!
    @IBOutlet weak var audioIndicatorStack: UIStackView!

    // MARK: Properties
    private let audioController = AudioController()
    private var place: Place
    private var images: [String] = []
    private var selectedPlaceImage: UIImage?
    private var height = 90.0 // height for the collection view
    private var likeButton: UIBarButtonItem?
    private var isStillInVC = true
    private var isLike = false {
        didSet {
            self.likeButton?.image = isLike ? .ic_heartCircleRed: .ic_heartCircle
        }
    }
    private var isLoading = false {
        didSet {
            self.setIndicator()
        }
    }
    var handleBack: ((_ place: Place) -> Void)?
    var selectedPlaceImageStr: String? {
        didSet {
            let imageView = UIImageView()
            imageView.fetchImage(self.selectedPlaceImageStr, .ic_placeholder)
            self.selectedPlaceImage = imageView.image
        }
    }

    // MARK: Init
    init(place: Place) {
        self.place = place
        self.images = place.images
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
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        SceneDelegate.shared?.rootNavigationController?.backgroundColor = .clear
        SceneDelegate.shared?.rootNavigationController?.shadowColor = .clear
        self.isStillInVC = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        SceneDelegate.shared?.rootNavigationController?.backgroundColor = .color_FFFFFF
        SceneDelegate.shared?.rootNavigationController?.shadowColor = .color_A3A3A3
        self.stopPlayAudio()
        self.isStillInVC = false
    }
}

// MARK: - Actions
private extension PlaceDetailsViewController {

    @IBAction func playAction(_ sender: Any) {
        self.setAudio()
    }

    @IBAction func zoomAction(_ sender: Any) {
        self.zoomInOutAnimation()
    }

    @objc func pop() {
        self._pop()
    }

    @objc func inviteAction() {
        let vc = InviteViewController(place: place)
        vc._push()
    }

    @objc func likeAction() {
        self.isLike.toggle()
        self.place.isFavorite = self.isLike
        PlaceController().addFivoraitePlace(place: place)
        handleBack?(place)
    }

}

// MARK: - Configurations
private extension PlaceDetailsViewController {

    func setUpView() {
        self.isLoading = false
        self.audioIndicatorStack.isHidden = true
        self.heightCollectionConstraint.constant = height
        self.setUpNaicgation()
        self.placeImageView.angleOffset = 180
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView._registerCell = PlaceImageCollectionViewCell.self
        self.collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
    }

    func setUpData() {
        self.isLike = self.place.isFavorite
        self.selectedPlaceImageStr = self.images.first
        self.placeImageView.image = self.selectedPlaceImage
        self.placeImageView.panoramaType = .cylindrical
        self.musicNameLabel.text = self.place.audioName
        self.descriptionLabel.numberOfLines = 3
        self.descriptionLabel.text = Strings.TAKE_TOUR_TITLE.replacingOccurrences(of: "{Club}", with: self.place.name ?? "")
        self.audioController.getAmplitudes = { [weak self] amplitudes in
            self?.audioIndicatorView.amplitudes = amplitudes
            if amplitudes.isEmpty {
                DispatchQueue.main.async {
                    self?.playButton.isSelected = false
                }
            }
        }
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
            self.audioIndicatorStack.isHidden = !self.zoomButton.isSelected
            self._isHideNavigation = self.zoomButton.isSelected
            self.rotationStack.isHidden = self.zoomButton.isSelected
            self.descriptionStack.isHidden = self.zoomButton.isSelected
            self.images = self.zoomButton.isSelected ? [] : self.place.images
            self.collectionView.reloadData()
            self.bottomStack.isLayoutMarginsRelativeArrangement = !self.zoomButton.isSelected
            self.heightCollectionConstraint.constant = self.zoomButton.isSelected ? 0 : self.height
            self.view.layoutIfNeeded()
        }
    }

}

extension PlaceDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PlaceImageCollectionViewCell = collectionView._dequeueReusableCell(for: indexPath)
        cell.object = self.images[indexPath.row]
        cell.configureCell()
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedPlaceImageStr = self.images[indexPath.row]
        self.placeImageView.image = self.selectedPlaceImage
        self.placeImageView.panoramaType = .cylindrical
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

private extension PlaceDetailsViewController {

    func setIndicator() {
        switch self.isLoading {
        case true:
            self.indicatorView.isHidden = false
            self.indicatorView.color = .color_FFFFFF
            self.playButton.isHidden = true
            self.indicatorView.startAnimating()
        case false:
            self.indicatorView.isHidden = true
            self.playButton.isHidden = false
            self.indicatorView.stopAnimating()
        }
    }

    func setAudio() {
        if self.playButton.isSelected {
            self.stopPlayAudio()
        } else {
            self.startPlayAudio()
        }
    }

    func startPlayAudio() {
        self.playButton.isSelected = true
        self.isLoading = true
        self.audioController.downloadAudio(with: self.place.audio, completion: { [weak self] url in
            DispatchQueue.main.async { [weak self] in
                self?.isLoading = false
                if let isStillInVC = self?.isStillInVC, isStillInVC {
                    debugPrint("playing")
                    self?.audioController.startPlaying(url)
                }
            }
        })
    }

    @objc func stopPlayAudio() {
        self.playButton.isSelected = false
        self.audioController.stopPlaying()
        self.audioController.stopEngine()
    }

}
