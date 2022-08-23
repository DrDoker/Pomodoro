//
//  Extension.swift
//  Pomodoro
//
//  Created by Serhii  on 22/08/2022.
//

import UIKit

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

extension CALayer {
    func pauseAnimation() {
        if !isPaused() {
            let pausedTime = convertTime(CACurrentMediaTime(), from: nil)
            speed = 0.0
            timeOffset = pausedTime
        }
    }

    func resumeAnimation() {
        if isPaused() {
            let pausedTime = timeOffset
            speed = 1.0
            timeOffset = 0.0
            beginTime = 0.0
            let timeSincePause = convertTime(CACurrentMediaTime(), from: nil) - pausedTime
            beginTime = timeSincePause
        }
    }

    func isPaused() -> Bool {
        return speed == 0
    }
}
