// _________SKAIK_MO_________
//
//  PrivacyPolicyViewController.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 11/07/2023.
//

import UIKit
import WebKit

class PrivacyPolicyViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var webView: WKWebView!

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
        setUpView()
        fetchData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

}

// MARK: - Actions
private extension PrivacyPolicyViewController {

}

// MARK: - Configurations
private extension PrivacyPolicyViewController {

    func setUpView() {
        self.view.cornerRadius = 25
    }

    func showLoader(_ isLoding: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
                Helper.showLoader(isLoding: isLoding)
            })
    }

    func fetchData() {
        self.showLoader(true)
        _ = PrivacyController().getPrivacy { value in
            if let value {
                self.webView.loadHTMLString(value, baseURL: nil)
            } else {
                self.webView.scrollView.emptyDataSet(title: Strings.PRIVACY_EMPTY_TITLE)
            }
        }.handlerDidFinishRequest(handler: {
            self.showLoader(false)
        }).handlerofflineLoad(handler: {
            self.showLoader(false)
            self.webView.scrollView.emptyDataSet(title: Strings.NETWORK_ERROR_TITLE)
        })
    }

}
