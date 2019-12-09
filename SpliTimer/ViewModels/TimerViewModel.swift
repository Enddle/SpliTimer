//
//  TimerViewModel.swift
//  SpliTimer
//
//  Created by Enddle Zheng on 12/8/19.
//  Copyright © 2019 Enddle Zheng. All rights reserved.
//

import SwiftUI
import Combine

class TimerViewModel: ObservableObject {
    
    @Published var mainTime: Int = 0
    @Published var subTimes: [Int] = [0]
    
    let rows = 2
    let columns = 3
    
    var active = 0 { didSet {didChange.send()} }
    @Published var timers: [CircleTimer] = [
        CircleTimer(id: 0, label: "Label 1", isTiming: true)
    ]
    
    var isMainTiming = false
    var canResetTime = false
    var canAddTimer = true
    
    var resetButton = ControlButton(id: 0, icon: "arrow.clockwise", color: Color(.systemGray), color2: Color(.systemGray3))
    var addButton = ControlButton(id: 1, icon: "plus", color: Color(.systemGray), color2: Color(.systemGray3))
    var startButton = ControlButton(id: 2, icon: "play.fill", color: Color(.systemGreen), icon2: "stop.fill", color2: Color(.systemRed))
    
    let didChange = PassthroughSubject<Void, Never>()
    
    var timer = Timer()
    
    func startTimer() {
        if (!isMainTiming) {
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(action), userInfo: nil, repeats: true)
            isMainTiming = true
            canResetTime = true
            
        } else {
            timer.invalidate()
            isMainTiming = false
        }
        didChange.send()
    }
    
    func resetTimer() {
        if (canResetTime) {
            timer.invalidate()
            mainTime = 0
            for n in 0..<subTimes.count {
                subTimes[n] = 0
            }
            canResetTime = false
        }
    }
    
    func addTimer() {
        if (canAddTimer) {
            let count = timers.count
            subTimes.append(0)
            timers.append(CircleTimer(id: count, label: "Label \(count + 1)"))
            if count == rows * columns - 1 {
                canAddTimer = false
            }
        }
    }
    
    func timerTapped(id: Int) {
        active = id
        for n in 0..<timers.count {
            if n == active {
                timers[active].isTiming = true
            } else {
                timers[n].isTiming = false
            }
        }
    }
    
    @objc func action() {
        mainTime += 1
        subTimes[active] += 1
    }
}
