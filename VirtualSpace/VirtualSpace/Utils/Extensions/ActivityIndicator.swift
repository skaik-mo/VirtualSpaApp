//
//  ActivityIndicator.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 19/07/2023.
//

import UIKit
import ProgressHUD

extension ProgressHUD {

    class func showIndicator() {
        ProgressHUD.show(interaction: false)
        ProgressHUD.colorAnimation = .color_8C4EFF
        ProgressHUD.animationType = .circleSpinFade
    }

    class func showIndicatorProgress(_ progress: Float) {
        ProgressHUD.colorAnimation = .color_8C4EFF
        ProgressHUD.colorProgress = .color_8C4EFF
        ProgressHUD.animationType = .circleSpinFade
        ProgressHUD.showProgress(CGFloat(progress))
    }

    class func dismissIndicator() {
        ProgressHUD.dismiss()
    }
}

extension UITableView {

    private func indicatorView() -> UIActivityIndicatorView {
        var activityIndicatorView = UIActivityIndicatorView()
        if self.tableFooterView == nil {
            let indicatorFrame = CGRect(x: 0, y: 0, width: self.bounds.width, height: 80)
            activityIndicatorView = UIActivityIndicatorView(frame: indicatorFrame)
            activityIndicatorView.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin]

            if #available(iOS 13.0, *) {
                activityIndicatorView.style = .medium
            } else {
                // Fallback on earlier versions
                activityIndicatorView.style = .medium
            }

            activityIndicatorView.color = .gray
            activityIndicatorView.hidesWhenStopped = true

            self.tableFooterView = activityIndicatorView
            return activityIndicatorView
        } else {
            return activityIndicatorView
        }
    }

    func addLoading(_ indexPath: IndexPath, closure: @escaping (() -> Void)) {
            if let lastVisibleIndexPath = self.indexPathsForVisibleRows?.last, indexPath == lastVisibleIndexPath && indexPath.row == self.numberOfRows(inSection: 0) - 1 {
                indicatorView().startAnimating()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    closure()
                }
            }
    }

    func stopLoading() {
        if self.tableFooterView != nil {
            self.indicatorView().stopAnimating()
            self.tableFooterView = nil
        }
    }
}
