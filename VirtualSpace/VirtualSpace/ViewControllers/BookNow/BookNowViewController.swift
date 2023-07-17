// _________SKAIK_MO_________
//
//  BookNowViewController.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 16/07/2023.
//

import UIKit

class BookNowViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var bookNowLabel: UILabel!
    @IBOutlet weak var selectdateLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var dateStack: UIStackView!

    // MARK: Properties

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
        setUpData()
        setUpView()
        fetchData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

}

// MARK: - Actions
private extension BookNowViewController {

    @IBAction func submitAction(_ sender: Any) {
        debugPrint(#function)
    }

    @objc func selectDate() {
        self.showDateOrTime { value in
            self.dateLabel.text = value
        }
    }

}

// MARK: - Configurations
private extension BookNowViewController {

    func setUpView() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.selectDate))
        self.dateStack.addGestureRecognizer(tap)
        self.dateStack.isUserInteractionEnabled = true
        self.submitButton.applyButtonStyle(.Primary(40))
    }

    func setUpData() {
        self.bookNowLabel.text = Strings.BOOK_NOW_TITLE
        self.selectdateLabel.text = Strings.SELECT_DATE_TITLE
        self.dateLabel.text = "9 Jul 2023"
        self.submitButton.titleLabel?.text = Strings.SUBMIT_TITLE
    }

    func fetchData() {

    }

}

private extension BookNowViewController {
    func showDateOrTime(handle: @escaping (_ value: String?) -> Void) {
        let alert = UIAlertController(style: .actionSheet, title: Strings.SELECT_DATE_TITLE)
        var isSelectedValue = false
        alert.addDatePicker(mode: .date, date: Date(), minimumDate: Date(), maximumDate: nil) { date in
            handle(date._stringDate)
            isSelectedValue = true
        }
        let okayAction = UIAlertAction.init(title: "OK", style: .cancel) { _ in
            if !isSelectedValue {
                handle(Date()._stringDate)
            }
        }
        alert.addAction(okayAction)
        self.present(alert, animated: true)
    }
}
