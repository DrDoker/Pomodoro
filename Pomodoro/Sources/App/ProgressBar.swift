//
//  ProgressBar.swift
//  Pomodoro
//
//  Created by Serhii  on 22/08/2022.
//

import UIKit

class ProgressBar: UIView {

    private var backgroundLayer: CAShapeLayer!
    private var foregroundLayer: CAShapeLayer!
    private var textLayer: CATextLayer!

    override func draw(_ rect: CGRect) {
        let wight = rect.width
        let height = rect.height

        let lineWight = 0.07 * min(wight, height)
        let center = CGPoint(x: wight / 2, y: height / 2)
        let radius = (min(wight, height) - lineWight) / 2

        let startAngle = -CGFloat.pi / 2
        let endAngle = startAngle + 2 * CGFloat.pi

        let circularPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)

        backgroundLayer = CAShapeLayer()
        backgroundLayer.path = circularPath.cgPath

        backgroundLayer.strokeColor = UIColor.lightGray.cgColor
        backgroundLayer.fillColor = UIColor.clear.cgColor
        backgroundLayer.lineWidth = lineWight
        backgroundLayer.lineCap = .round

        foregroundLayer = CAShapeLayer()
        foregroundLayer.path = circularPath.cgPath

        foregroundLayer.strokeColor = UIColor.systemRed.cgColor
        foregroundLayer.fillColor = UIColor.clear.cgColor
        foregroundLayer.lineWidth = lineWight
        foregroundLayer.lineCap = .round

      //  foregroundLayer.strokeStart = 0.2
        foregroundLayer.strokeEnd = 0.6

        layer.addSublayer(backgroundLayer)
        layer.addSublayer(foregroundLayer)
    }

}
