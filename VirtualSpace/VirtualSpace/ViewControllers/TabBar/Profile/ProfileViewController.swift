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
    @IBOutlet weak var tableView: UITableView!

    // MARK: Properties
    var menu: [GlobalConstants.ProfileMenu] = []

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
    }

    func setUpTableView() {
        self.tableView._registerHeaderAndFooter = ProfileHeaderTableViewCell.self
        self.tableView.sectionHeaderHeight = 220
        self.tableView._registerCell = ProfileTableViewCell.self
        self.tableView._registerCell = SwitchTableViewCell.self
        self.tableView._registerCell = DeleteTableViewCell.self
        self.tableView.rowHeight = 50
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }

}

// MARK: - set Up Navigation
extension ProfileViewController {
    func getUpNavigationItem() -> UINavigationItem {
        let navigationItem = UINavigationItem()
        navigationItem.title = Strings.PROFILE_TITLE
        let logout = UIBarButtonItem(title: Strings.LOGOUT_TITLE, style: .plain, target: self, action: #selector(logoutAction))
        logout.setTitleTextAttributes([.font: UIFont.poppinsSemiBold14, .foregroundColor: UIColor.color_8C4EFF], for: .normal)
        navigationItem.rightBarButtonItems = [logout]
        return navigationItem
    }
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.menu.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = self.menu[indexPath.row]
        if item == .AccountPrivacy {
            let cell: SwitchTableViewCell = tableView._dequeueReusableCell()
            cell.object = item.title
            cell.configureCell()
            return cell
        } else if item == .DeleteAccount {
            let cell: DeleteTableViewCell = tableView._dequeueReusableCell()
            cell.object = item.title
            cell.configureCell()
            return cell
        }
        let cell: ProfileTableViewCell = tableView._dequeueReusableCell()
        cell.object = item.title
        cell.configureCell()
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.menu[indexPath.row].action()
    }

    // MARK: Header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header: ProfileHeaderTableViewCell = tableView._dequeueReusableHeaderFooterView()
        header.configureHeader()
        return header
    }

}
