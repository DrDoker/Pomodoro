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

    let workTimeInSeconds = 25.0
    let vacationTimeInSeconds = 10.0

    var isStarted = false
    var isWorkTime = true
    var timer = Timer()
    var timeCounter = 25.0

    // MARK: - Labels Outlets

    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.text = timeCounter.minuteSecondMS
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 45, weight: .thin)
        label.textColor = .black
        return label
    }()

    // MARK: - Buttons Outlets

    private lazy var startStopButton: UIButton = {
        let button = UIButton(type: .system)

        let configSymbol = UIImage.SymbolConfiguration(pointSize: 50, weight: .thin, scale: .default)
        let image = UIImage(systemName: "play", withConfiguration: configSymbol)
        button.setImage(image, for: .normal)

        button.tintColor = .black
        button.addTarget(self, action: #selector(startStopButtonPressed), for: .touchUpInside)
        return button
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupHierarchy()
        setupLayout()

        view.backgroundColor = .systemYellow
    }

    // MARK: - Setup

    private func setupHierarchy() {
        view.addSubview(timeLabel)
        view.addSubview(startStopButton)
    }

    private func setupLayout() {
        timeLabel.snp.makeConstraints { make in
            make.center.equalTo(view)
        }

        startStopButton.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view).offset(70)
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

        timeCounter -= 0.001
        let timeString = timeCounter.minuteSecondMS
        timeLabel.text = timeString

        print(timeString)

        if timeCounter <= 0 && isWorkTime {
            isWorkTime = false
            timeCounter = vacationTimeInSeconds
            timeLabel.textColor = .red
            startStopButton.tintColor = .red
            timer.invalidate()
            isStarted = false
            startStopButton.setImage(palyImage, for: .normal)
            timeLabel.text = timeCounter.minuteSecondMS
        } else if timeCounter <= 0 && !isWorkTime {
            isWorkTime = true
            timeCounter = workTimeInSeconds
            timeLabel.textColor = .black
            startStopButton.tintColor = .black
            timer.invalidate()
            isStarted = false
            startStopButton.setImage(palyImage, for: .normal)
            timeLabel.text = timeCounter.minuteSecondMS
        }
    }
}

extension TimeInterval {
    var hourMinuteSecondMS: String {
        String(format:"%d:%02d:%02d.%02d", hour, minute, second, millisecond)
    }
    var minuteSecondMS: String {
        String(format:"%d:%02d.%02d", minute, second, millisecond)
    }
    var hour: Int {
        Int((self/3600).truncatingRemainder(dividingBy: 3600))
    }
    var minute: Int {
        Int((self/60).truncatingRemainder(dividingBy: 60))
    }
    var second: Int {
        Int(truncatingRemainder(dividingBy: 60))
    }
    var millisecond: Int {
        Int((self*100).truncatingRemainder(dividingBy: 100))
    }
}
