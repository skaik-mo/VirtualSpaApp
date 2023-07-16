//_________SKAIK_MO_________
//  
//  TherapistViewController.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 16/07/2023.
//

import UIKit

class TherapistViewController: UIViewController {

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
private extension TherapistViewController {

}

// MARK: - Configurations
private extension TherapistViewController {

    func setUpView() {

    }

    func setUpData() {

    }

    func fetchData() {

    }

}

