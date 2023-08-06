//_________SKAIK_MO_________
//
//  MSSPhoneNumberPickerViewController.swift
//
//
//  Created by Mohammed Skaik on 06/08/2023.
//

import UIKit

class MSSPhoneNumberPickerViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!

    // MARK: Properties
    private let mssPhoneNumber = MSSPhoneNumber()
    private var countries: [Country] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    var getSelectedCountry: ((Country) -> Void)?

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
    }


}

extension MSSPhoneNumberPickerViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchForText(searchText)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchForText(searchBar.text)
        searchBar.endEditing(true)
    }
}

// MARK: - Configurations
private extension MSSPhoneNumberPickerViewController {

    func setUpView() {
        searchBar.delegate = self
        searchBar.searchTextField.font = .systemFont(ofSize: 14, weight: .regular)
        searchBar.searchTextField.textColor = .black
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Search", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        self.tableView.register(UINib(nibName: CountryTableViewCell.id, bundle: nil), forCellReuseIdentifier: CountryTableViewCell.id)
        self.tableView.contentInset.top = 10
        self.tableView.contentInset.bottom = 10
        self.countries = mssPhoneNumber.countries
        self.tableView.rowHeight = 40

    }

    func searchForText(_ text: String?) {
        guard let text, !text.isEmpty else {
            self.countries = mssPhoneNumber.countries
            return
        }
        self.countries = mssPhoneNumber.getCountries(text)
    }

}

extension MSSPhoneNumberPickerViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        countries.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CountryTableViewCell.id) as? CountryTableViewCell else { return UITableViewCell() }
        cell.country = countries[indexPath.row]
        cell.configureCell()
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.getSelectedCountry?(countries[indexPath.row])
        self.dismiss(animated: true)
    }

}
