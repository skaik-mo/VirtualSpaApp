// _________SKAIK_MO_________
//
//  TherapistViewController.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 16/07/2023.
//

import UIKit

class TherapistViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var tableView: GeneralTableView!

    // MARK: Properties
    private var therapist: UserModel
    var isInfoSelected = false

    // MARK: Init
    init(therapist: UserModel) {
        self.therapist = therapist
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

// MARK: - Actions
private extension TherapistViewController {

    @objc func optionAction() {
        guard let therapistID = therapist.id else { return }
        ReportController().optionPost(therapistID: therapistID)
    }

}

// MARK: - Configurations
private extension TherapistViewController {

    func setUpView() {
        TherapistHeaderTableViewCell.isInfoSelected = false
        self.addOption()
        self.tableView.contentInset = UIEdgeInsets(top: -10, left: 0, bottom: -20, right: 0)
        self.tableView.isPullToRefreshEnable = true
        self.tableView.isLoadMoreEnable = true
        self.tableView.header = TherapistHeaderTableViewCell.self
        self.tableView.sectionHeaderHeight = 335
        self.tableView.cell = TherapistInfoTableViewCell.self
        self.tableView.cell = PlaceTableViewCell.self
        self.tableView.cell = PostTableViewCell.self
        self.tableView.handleCell = { [weak self] indexPath in
            guard let self else { return nil }
            if self.isInfoSelected {
                if indexPath.row == 0 {
                    let cell: TherapistInfoTableViewCell = self.tableView._dequeueReusableCell()
                    cell.object = self.tableView.objects[indexPath.row]
                    cell.configureCell()
                    return cell
                }
                let cell: PlaceTableViewCell = self.tableView._dequeueReusableCell()
                cell.object = self.tableView.objects[indexPath.row]
                cell.configureCell()
                return cell
            }
            return nil
        }
        self.tableView.handleHeightCell = { [weak self] indexPath in
            guard let self else { return 0 }
            if indexPath.item == 0 {
                return self.isInfoSelected ? UITableView.automaticDimension : 330
            }
            return self.isInfoSelected ? 85 : 330
        }
    }

    func setUpData() {
        self.title = Strings.MESSAGE_THERAPIST_TITLE
    }

    func addOption() {
        let optionButton = UIBarButtonItem(image: .ic_more, style: .done, target: self, action: #selector(optionAction))
        self.navigationItem.rightBarButtonItem = optionButton
    }
}

extension TherapistViewController {
    func fetchData() {
        switch self.isInfoSelected {
        case true:
            self.tableView.resetTableView(request: .GetPlacesByTherapist(self.therapist))
        case false:
            self.tableView.resetTableView(request: .GetPostsByUser(self.therapist))
        }
    }
}
