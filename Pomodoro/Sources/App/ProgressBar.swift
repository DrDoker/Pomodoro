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

    public var progress: CGFloat = 0 {
        didSet {
            didProgressUpdated()
        }
    }

    override func draw(_ rect: CGRect) {

        let wight = rect.width
        let height = rect.height
        let lineWight = 0.07 * min(wight, height)

        backgroundLayer = createCircularLayer(rect: rect,
                                                 strokeColor: UIColor.lightGray.cgColor,
                                                 fillColor: UIColor.clear.cgColor,
                                                 lineWidth: lineWight)

        foregroundLayer = createCircularLayer(rect: rect,
                                                 strokeColor: UIColor.systemGreen.cgColor,
                                                 fillColor: UIColor.clear.cgColor,
                                                 lineWidth: lineWight)

        layer.addSublayer(backgroundLayer)
        layer.addSublayer(foregroundLayer)
    }

    private func createCircularLayer(rect: CGRect, strokeColor: CGColor, fillColor: CGColor, lineWidth: CGFloat) -> CAShapeLayer {

        let wight = rect.width
        let height = rect.height

        let center = CGPoint(x: wight / 2, y: height / 2)
        let radius = (min(wight, height) - lineWidth) / 2

        let startAngle = -CGFloat.pi / 2
        let endAngle = startAngle + 2 * CGFloat.pi

        let circularPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)

        let shapeLayer = CAShapeLayer()

        shapeLayer.path = circularPath.cgPath

        shapeLayer.strokeColor = strokeColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.fillColor = fillColor
        shapeLayer.lineCap = .round

        return shapeLayer
    }

    private func didProgressUpdated() {
        foregroundLayer?.strokeEnd = progress
    }

}
