//
//  TabBarIndicatorView.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 11/07/2023.
//

import Foundation
import UIKit

class TabBarIndicatorView: UITabBar {

    // MARK: - Properties
    private var indicatorYOffset: CGFloat = 0
    private var indicatorHeight: CGFloat = 1
    var indicatorWidth: CGFloat = 20
    var indicatorView: UIView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUpTabBar()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setUpTabBar()
    }

    private func setUpTabBar() {
        self.backgroundColor = .color_FFFFFF
        self.barTintColor = .color_FFFFFF
        self.shadowImage = UIImage()
        self.backgroundImage = UIImage()
        self.setUpIndcator()
        self.addLineInTabBar()
    }

    private func setUpIndcator() {
        self.addSubview(indicatorView)
        self.indicatorView.backgroundColor = .color_8C4EFF

    }

    func indicatorAnimate(_ selectedIndex: Int) {
        let tabWidth = self.bounds.width / CGFloat(self.items?.count ?? 1)
        let xPosition = CGFloat(selectedIndex) * tabWidth + (tabWidth - indicatorWidth) / 2
        let yPosition = indicatorYOffset
        UIView.animate(withDuration: 0.2) {
            self.indicatorView.frame = CGRect(x: xPosition, y: yPosition, width: self.indicatorWidth, height: self.indicatorHeight)
        }
    }

    func addLineInTabBar() {
        let lineView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: 1))
        lineView.backgroundColor = .color_000000.withAlphaComponent(0.12)
        self.addSubview(lineView)
    }

}
