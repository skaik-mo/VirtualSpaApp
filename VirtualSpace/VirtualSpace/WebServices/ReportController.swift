//
//  ReportController.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 13/08/2023.
//

import UIKit

class ReportController {
    private let referance: FirebaseFirestoreController = FirebaseFirestoreController().setFirebaseReference(.Report)

    func setReport(report: [String: Any], message: String) {
        SceneDelegate.shared?._topVC?._showAlert(styleOK: .destructive, message: message, buttonAction1: {
            _ = self.referance.setData(dictionary: report, isShowLoader: false, success: { })
        })
    }

    func optionPost(therapistID: String) {
        guard let userID = UserController().fetchUser()?.id else { return }
        let alert = UIAlertController(title: Strings.OPTION_TITLE, message: nil, preferredStyle: .actionSheet)
        let reportAction = UIAlertAction(title: Strings.REPORT_TITLE, style: .default) { _ in
            let report = Report(userID: userID, therapistID: therapistID)
            self.setReport(report: report.getDictionaryTherapist(), message: Strings.CONFIRM_REPORT_THERAPIST_MESSAGE)
        }
        alert.addAction(reportAction)
        let cancelAction = UIAlertAction(title: Strings.CANCEL_TITLE, style: .cancel)
        alert.addAction(cancelAction)
        SceneDelegate.shared?.window?.rootViewController?._presentVC(alert)
    }

}
