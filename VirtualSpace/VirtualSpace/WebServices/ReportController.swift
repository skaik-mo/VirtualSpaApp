//
//  ReportController.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 13/08/2023.
//

import Foundation

class ReportController {
    private let referance: FirebaseFirestoreController = FirebaseFirestoreController().setFirebaseReference(.Report)

    func setReport(report: Report) {
        SceneDelegate.shared?._topVC?._showAlert(styleOK: .destructive, message: Strings.CONFIRM_REPORT_MESSAGE, buttonAction1: {
            _ = self.referance.setData(dictionary: report.getDictionary(), isShowLoader: false, success: { })
        })
    }

}
