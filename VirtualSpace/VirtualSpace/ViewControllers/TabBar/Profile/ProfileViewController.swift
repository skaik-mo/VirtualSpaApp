// _________SKAIK_MO_________
//
//  ProfileViewController.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 11/07/2023.
//

import UIKit

class ProfileViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var tableView: GeneralTableView!

    // MARK: Properties
    private var menu: [GlobalConstants.ProfileMenu] = []

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
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }

}

// MARK: - Actions
private extension ProfileViewController {

    @objc func logoutAction() {
        UserController().logout()
    }
}

// MARK: - Configurations
private extension ProfileViewController {

    func setUpView() {
        self.setUpTableView()
    }

    func setUpData() {
        let userMenu: [GlobalConstants.ProfileMenu] = [.AccountPrivacy, .Reservations, .Massages, .Following, .Friends, .EditProfile, .ChangePassword, .DeleteAccount]
        let busniessMenu: [GlobalConstants.ProfileMenu] = [.AccountPrivacy, .Massages, .Followers, .EditProfile, .ChangePassword]
        self.menu = UserController().fetchUser()?.type == .User ? userMenu : busniessMenu
        self.tableView.objects = self.menu
    }

    func setUpTableView() {
        self.tableView.header = ProfileHeaderTableViewCell.self
        self.tableView.sectionHeaderHeight = 220
        self.tableView.cell = ProfileTableViewCell.self
        self.tableView.cell = SwitchTableViewCell.self
        self.tableView.cell = DeleteTableViewCell.self
        self.tableView.rowHeight = 50
        self.tableView.handleCell = { [weak self] indexPath in
            guard let self else { return nil }
            let item = self.menu[indexPath.row]
            if item == .AccountPrivacy {
                let cell: SwitchTableViewCell = self.tableView._dequeueReusableCell()
                cell.object = item
                cell.configureCell()
                return cell
            } else if item == .DeleteAccount {
                let cell: DeleteTableViewCell = self.tableView._dequeueReusableCell()
                cell.object = item
                cell.configureCell()
                return cell
            }
            let cell: ProfileTableViewCell = self.tableView._dequeueReusableCell()
            cell.object = item
            cell.configureCell()
            return cell
        }
    }

}

// MARK: - set Up Navigation
extension ProfileViewController {
    func getUpNavigationItem() -> UINavigationItem {
        let navigationItem = UINavigationItem()
        navigationItem.title = Strings.MY_PROFILE_TITLE
        let logout = UIBarButtonItem(title: Strings.LOGOUT_TITLE, style: .plain, target: self, action: #selector(logoutAction))
        logout.setTitleTextAttributes([.font: UIFont.poppinsSemiBold14, .foregroundColor: UIColor.color_8C4EFF], for: .normal)
        navigationItem.rightBarButtonItems = [logout]
        return navigationItem
    }
}
