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
    var timer = Timer()
    var timeCounter = 0

    // MARK: - Labels Outlets

    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00"
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
            timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        } else {
            timer.invalidate()
            startStopButton.setImage(palyImage, for: .normal)
        }
    }

    @objc func timerAction(timer: Timer) {
        let configSymbol = UIImage.SymbolConfiguration(pointSize: 50, weight: .thin, scale: .default)
        let palyImage = UIImage(systemName: "play", withConfiguration: configSymbol)

        timeCounter += 1
        let time = scondsToMinutesSeconds(seconds: timeCounter)
        let timeString =  makeTimeString(minutes: time.0, seconds: time.1)
        timeLabel.text = timeString

        if timeCounter == 20 && isWorkTime {
            isWorkTime = false
            timeCounter = 0
            timeLabel.textColor = .red
            startStopButton.tintColor = .red
            timer.invalidate()
            isStarted = false
            startStopButton.setImage(palyImage, for: .normal)
        } else if timeCounter == 10 && !isWorkTime {
            isWorkTime = true
            timeCounter = 0
            timeLabel.textColor = .black
            startStopButton.tintColor = .black
            timer.invalidate()
            isStarted = false
            startStopButton.setImage(palyImage, for: .normal)
        }
    }

    func scondsToMinutesSeconds(seconds: Int) -> (Int, Int) {
        let minutes = (seconds % 3600) / 60
        let seconds = (seconds % 3600) % 60
        return (minutes, seconds)
    }

    func makeTimeString(minutes: Int, seconds: Int) -> String {
        var timeString = ""
        timeString += String(format: "%02d", minutes)
        timeString += " : "
        timeString += String(format: "%02d", seconds)
        return timeString
    }
}
