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
    private var therapist: UserModel
    private var date: Date?
    private var isEnableSubmit = true {
        didSet {
            self.submitButton.isEnabled = isEnableSubmit
        }
    }

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
        setUpData()
        setUpView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

}

// MARK: - Actions
private extension BookNowViewController {

    @IBAction func submitAction(_ sender: Any) {
        self.booking()
    }

    @objc func selectDate() {
        self.showDateOrTime { value in
            self.date = value
            self.dateLabel.text = value?._stringDate
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
        self.date = Date()
        self.dateLabel.text = self.date?._stringDate
        self.submitButton.titleLabel?.text = Strings.SUBMIT_TITLE
    }

}

private extension BookNowViewController {
    func showDateOrTime(handle: @escaping (_ value: Date?) -> Void) {
        let alert = UIAlertController(style: .actionSheet, title: Strings.SELECT_DATE_TITLE)
        var isSelectedValue = false
        alert.addDatePicker(mode: .date, date: Date(), minimumDate: Date(), maximumDate: Date()._add(years: 1)) { date in
            handle(date)
            isSelectedValue = true
        }
        let okayAction = UIAlertAction.init(title: Strings.OK_TITLE, style: .cancel) { _ in
            if !isSelectedValue {
                handle(Date())
            }
        }
        alert.addAction(okayAction)
        self.present(alert, animated: true)
    }
}

private extension BookNowViewController {
    func validation() -> Bool {
        guard NilValidationRule(field: Strings.INVALID_DATE_TIME_MESSAGE).hasValidValue(self.dateLabel.text ?? "") else { return false }
        return true
    }

    func getReservation() -> Reservation? {
        guard let therapistID = self.therapist.id, let reservationUser = UserController().fetchUser(), let reservationUserID = reservationUser.id, let date else { return nil }
        return .init(therapistID: therapistID, therapistName: self.therapist.name, therapistImage: self.therapist.image,
                     reservationUserID: reservationUserID, reservationUserName: reservationUser.name,
                     reservationUserEmail: reservationUser.email, reservationUserPhone: reservationUser.phone,
                     reservationUserImage: reservationUser.image, reservationUserCoverImage: reservationUser.coverImage,
                     date: date, status: .Pending)
    }

    func booking() {
        self.isEnableSubmit = false
        guard validation(), let reservation = getReservation() else {
            self.isEnableSubmit = true
            return
        }
        _ = ReservationController().setReservation(reservation: reservation, success: {
            self._dismissVC()
        }).handlerDidFinishRequest(handler: {
            self.isEnableSubmit = true
        }).handlerofflineLoad(handler: {
            self.isEnableSubmit = true
        })
    }
}
