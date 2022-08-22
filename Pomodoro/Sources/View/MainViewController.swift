//
//  MainViewController.swift
//  Pomodoro
//
//  Created by Serhii  on 20/08/2022.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    // MARK: - Propertis

    var isStarted = false
    var isWorkTime = true
    let workTimeInSeconds = 25.0
    let vacationTimeInSeconds = 25.0
    var timeCounter = 0.0
    var timer = Timer()


    let shapeLayer = CAShapeLayer()

    // MARK: - Labels Outlets

    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.text = timeCounter.minuteSecondMS
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 45, weight: .thin)
        label.textColor = .systemGreen
        return label
    }()

    // MARK: - Buttons Outlets

    private lazy var startStopButton: UIButton = {
        let button = UIButton(type: .system)

        let configSymbol = UIImage.SymbolConfiguration(pointSize: 50, weight: .thin, scale: .default)
        let image = UIImage(systemName: "play", withConfiguration: configSymbol)
        button.setImage(image, for: .normal)

        button.tintColor = .systemGreen
        button.addTarget(self, action: #selector(startStopButtonPressed), for: .touchUpInside)
        return button
    }()

    // MARK: - View Outlets

    private lazy var progressBarView: UIView = {
        let view = UIView()
        return view
    }()

    // MARK: - Lifecycle

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        animationCircular()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupLayout()

        timeCounter = workTimeInSeconds
        view.backgroundColor = .black


    }

    // MARK: - Setup

    private func setupHierarchy() {
        view.addSubview(progressBarView)
        view.addSubview(timeLabel)
        view.addSubview(startStopButton)
    }

    private func setupLayout() {
        timeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(view)
            make.left.equalTo(view).offset(117)
        }

        startStopButton.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view).offset(70)
        }

        progressBarView.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view).offset(11)
            make.height.equalTo(300)
            make.width.equalTo(300)
        }
    }

    // MARK: - Actions

    @objc func startStopButtonPressed(sender: UIButton) {
        let configSymbol = UIImage.SymbolConfiguration(pointSize: 50, weight: .thin, scale: .default)
        let palyImage = UIImage(systemName: "play", withConfiguration: configSymbol)
        let stopImage = UIImage(systemName: "pause", withConfiguration: configSymbol)

        isStarted = !isStarted
        if isStarted {
            timer.invalidate()
            progressAnimation()
            startStopButton.setImage(stopImage, for: .normal)
            timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        } else {
            timer.invalidate()
            startStopButton.setImage(palyImage, for: .normal)
        }
    }

    @objc func timerAction(timer: Timer) {
        let configSymbol = UIImage.SymbolConfiguration(pointSize: 50, weight: .thin, scale: .default)
        let palyImage = UIImage(systemName: "play", withConfiguration: configSymbol)

        timeCounter -= timer.timeInterval

        let timeString = timeCounter.minuteSecondMS
        timeLabel.text = timeString


        if timeCounter <= 0 && isWorkTime {
            isWorkTime = false
            timeCounter = vacationTimeInSeconds
            timeLabel.textColor = .systemRed
            startStopButton.tintColor = .systemRed
            timer.invalidate()
            isStarted = false
            startStopButton.setImage(palyImage, for: .normal)
            timeLabel.text = timeCounter.minuteSecondMS
        } else if timeCounter <= 0 && !isWorkTime {
            isWorkTime = true
            timeCounter = workTimeInSeconds
            timeLabel.textColor = .systemGreen
            startStopButton.tintColor = .systemGreen
            timer.invalidate()
            isStarted = false
            startStopButton.setImage(palyImage, for: .normal)
            timeLabel.text = timeCounter.minuteSecondMS
        }
    }

    func animationCircular() {
        let width = progressBarView.frame.width
        let height = progressBarView.frame.width

        print(width, height)

        let lineWidth = 0.07 * min(width, height)

        let center = CGPoint(x: width / 2, y: height / 2)
        let radius = (min(width, height) - lineWidth) / 2

        let startAngle = -CGFloat.pi / 2
        let endAngle = startAngle + 2 * CGFloat.pi

        let circularPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)

        shapeLayer.path = circularPath.cgPath
        shapeLayer.lineWidth = lineWidth
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.systemGreen.cgColor
        shapeLayer.strokeEnd = 1
        shapeLayer.lineCap = CAShapeLayerLineCap.round

        progressBarView.layer.addSublayer(shapeLayer)
    }

    func progressAnimation() {
            // created circularProgressAnimation with keyPath
            let circularProgressAnimation = CABasicAnimation(keyPath: "strokeEnd")
            // set the end time
            circularProgressAnimation.duration = CFTimeInterval(timeCounter)
        circularProgressAnimation.
            circularProgressAnimation.toValue = 0
            circularProgressAnimation.fillMode = CAMediaTimingFillMode.forwards
            circularProgressAnimation.isRemovedOnCompletion = true
            shapeLayer.add(circularProgressAnimation, forKey: "progressAnimation")
    }

}

extension TimeInterval {
    var minuteSecondMS: String {
        String(format:"%02d:%02d.%02d", minute, second, millisecond)
    }
    var secondMS: String {
        String(format:"%02d:%02d", second, millisecond)
    }
    var hour: Int {
        Int((self / 3600).truncatingRemainder(dividingBy: 3600))
    }
    var minute: Int {
        Int((self / 60).truncatingRemainder(dividingBy: 60))
    }
    var second: Int {
        Int(truncatingRemainder(dividingBy: 60))
    }
    var millisecond: Int {
        Int((self * 100).truncatingRemainder(dividingBy: 100))
    }
}
