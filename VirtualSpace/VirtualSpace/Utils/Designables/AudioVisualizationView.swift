//
//  AudioVisualizationView.swift
//  VirtualSpace
//
//  Created by Mohammed Skaik on 31/07/2023.
//

import UIKit

class AudioVisualizationView: UIView {
    var amplitudes: [Float] = [] {
        didSet {
            DispatchQueue.main.async {
                self.setNeedsDisplay()
            }
        }
    }

    let barColor: UIColor = .white.withAlphaComponent(0.35)
    let spaceColor: UIColor = .red
    let numberOfBars: Int = 30
    let spaceWidth: CGFloat = 2.0

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        drawIndicator(rect)
    }

    func drawIndicator(_ rect: CGRect) {
        guard !amplitudes.isEmpty else { return }
        let barWidth = abs(bounds.width - CGFloat(numberOfBars - 1) * spaceWidth) / CGFloat(numberOfBars)
        let maxValue = amplitudes.max() ?? 1.0
        for i in 0..<numberOfBars {
            let x = CGFloat(i) * (barWidth + spaceWidth)
            let barHeight = bounds.height * CGFloat(amplitudes[i]) / CGFloat(maxValue)

            let barRect = CGRect(x: x, y: bounds.height - barHeight, width: barWidth, height: barHeight)
            let barPath = UIBezierPath(roundedRect: barRect, cornerRadius: 0)

            barColor.setFill()
            barPath.fill()
        }
    }
}
