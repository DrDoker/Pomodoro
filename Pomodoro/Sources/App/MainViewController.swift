//
//  MainViewController.swift
//  Pomodoro
//
//  Created by Serhii  on 20/08/2022.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    // MARK: - Logica

    var isStarted = false

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
        let stopImage = UIImage(systemName: "stop", withConfiguration: configSymbol)

        isStarted = !isStarted
        if isStarted {
            startStopButton.setImage(stopImage, for: .normal)
        } else {
            startStopButton.setImage(palyImage, for: .normal)
        }
    }
}
