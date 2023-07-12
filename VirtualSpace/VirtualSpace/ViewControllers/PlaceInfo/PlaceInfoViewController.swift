//_________SKAIK_MO_________
//  
//  PlaceInfoViewController.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 12/07/2023.
//

import UIKit

class PlaceInfoViewController: UIViewController {

    // MARK: Outlets

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
        setUpData()
        fetchData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

}

// MARK: - Actions
private extension PlaceInfoViewController {

}

// MARK: - Configurations
private extension PlaceInfoViewController {

    func setUpView() {

    }

    func setUpData() {

    }

    func fetchData() {

    }

}

