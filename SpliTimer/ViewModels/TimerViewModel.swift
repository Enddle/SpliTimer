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
    
    @Published var mainTime = STTime()
    
    @Published var rows: Int
    @Published var columns: Int
    @Published var items: Int
    
    @Published var useEmptyLabel: Bool
    @Published var placeholder: String
    
    var active = 0 { didSet {didChange.send()} }
    var activeId = 0
    @Published var timers: [STSubTimer]
    var defaultTimer = STSubTimer(id: 0, label: "SpliTimer 0", isTiming: true)
    
    @Published var isMainTiming = false
    // didChange not working when pausing, temporary published
    
    var canResetTime = false
    var canAddTimer = true
    var canAddItemTimer = true
    
    var resetButton = ControlButton(id: 0, icon: "arrow.clockwise", color: Color(.systemGray), color2: Color(.systemGray3))
    var addButton = ControlButton(id: 1, icon: "plus", color: Color(.systemGray), color2: Color(.systemGray3))
    var startButton = ControlButton(id: 2, icon: "play.fill", color: Color(.systemGreen), icon2: "stop.fill", color2: Color(.systemRed))
    
    let didChange = PassthroughSubject<Void, Never>()
    
    init() {
        let defaults = UserDefaults.standard
        
        rows = defaults.integer(forKey: "TimerRows")
        columns = defaults.integer(forKey: "TimerColumns")
        items = defaults.integer(forKey: "TimerItems")
        
        useEmptyLabel = defaults.bool(forKey: "LabelUseEmpty")
        placeholder = defaults.string(forKey: "LabelPlaceholder") ?? "SpliTimer"
        
        var restoredTimers: [STSubTimer] = []
        if let data = defaults.object(forKey: "SavedLabels") as? [String] {
            for (n, label) in zip(data.indices, data) {
                restoredTimers.append(STSubTimer(id: n, label: label, isTiming: (n == self.active) ))
            }
        }
        self.timers = restoredTimers.count > 0 ? restoredTimers : [defaultTimer]
        
        defaultTimer.label = useEmptyLabel ? "" : "\(placeholder) \(defaultTimer.id)"
        
        rows = rows == 0 ? 2 : rows
        columns = columns == 0 ? 3 : columns
        items = items == 0 ? 10 : items
        countTimers()
    }
    
    var timer = Timer()
    let haptic = HapticFeedback()
    
    func startTimer() {
        if !isMainTiming {
            if canResetTime {
                haptic.selection()
            } else {
                haptic.success()
            }
            timer = Timer(timeInterval: 0.1, target: self, selector: #selector(action), userInfo: nil, repeats: true)
            RunLoop.current.add(timer, forMode: RunLoop.Mode.common)
            isMainTiming = true
            canResetTime = true
            
        } else {
            haptic.selection()
            timer.invalidate()
            isMainTiming = false
        }
        didChange.send()
    }
    
    func resetTimers() {
        if canResetTime {
            haptic.success()
            timer.invalidate()
            mainTime.raw = 0
            for n in timers.indices {  // loop all
                timers[n].subTime.raw = 0
            }
            canResetTime = false
            isMainTiming = false
        } else {
            haptic.lightImpact()
        }
    }
    
    func addTimer(isList: Bool = false) {
        if (canAddTimer || (isList && canAddItemTimer)) {
            haptic.selection()
            
            let id = (timers.last(where: {!$0.isRemoved})?.id ?? -1) + 1
            
            if let reuseOffset = timers.firstIndex(where: {$0.isRemoved}) {  // reuse hidden timer
                timers[reuseOffset] = STSubTimer(id: id, label: useEmptyLabel ? "" : "\(placeholder) \(id)")
                print("reusing \(reuseOffset) as \(id)")
            } else {
                
                timers.append(STSubTimer(id: id, label: useEmptyLabel ? "" : "\(placeholder) \(id)"))
            }
            countTimers()
            saveTimers()
        } else {
            haptic.error()
        }
    }
    
    func removeTimer(index: Int) {
        if timers.indices ~= index {
            
            timers[index].isRemoved = true  // hide for reuse
            timers.move(fromOffsets: [index], toOffset: timers.indices.endIndex)
            
            if let activeOffset = timers.firstIndex(where: {$0.id == activeId && !$0.isRemoved}) {
                self.active = activeOffset
            } else {
                timerTapped(index: timers.firstIndex(where: {!$0.isRemoved}) ?? 0)
            }
            countTimers()
            saveTimers()
        }
    }
    
    func removeAllTimers() {
        resetTimers()
        
        for n in timers.indices {  // loop all
            timers[n].isRemoved = true
        }
        timers[0] = defaultTimer
        
        countTimers()
        saveTimers()
    }
    
    func countTimers() {
        let count = timers.count {!$0.isRemoved}
        canAddTimer = (count < rows * columns)
        canAddItemTimer = (count < items)
    }
    
    func timerTapped(id: Int) {
        haptic.selection()
        activeId = id
        for n in timers.indices {  // loop all
            if timers[n].id == activeId {
                active = n
                timers[active].isTiming = true
            } else {
                timers[n].isTiming = false
            }
        }
    }
    
    func timerTapped(index: Int) {
        haptic.selection()
        active = index
        for n in timers.indices {  // loop all
            if n == active {
                activeId = timers[active].id
                timers[active].isTiming = true
            } else {
                timers[n].isTiming = false
            }
        }
    }
    
    @objc func action() {
        mainTime.raw += 1
        timers[active].subTime.raw += 1
    }
    
    let defaults = UserDefaults.standard
    
    func saveTimers() {
        var data: [String] = []
        for timer in timers {
            if (!timer.isRemoved) {
                data.append(timer.label)
            }
        }
        defaults.set(data, forKey: "SavedLabels")
    }
    
    func saveSettings() {
        if items < rows * columns {
            items = rows * columns
        }
        
        defaults.set(rows, forKey: "TimerRows")
        defaults.set(columns, forKey: "TimerColumns")
        defaults.set(items, forKey: "TimerItems")
        
        defaults.set(useEmptyLabel, forKey: "LabelUseEmpty")
        defaults.set(placeholder, forKey: "LabelPlaceholder")
        
        countTimers()
    }
    
    func restoreSettings() {
        rows = 2
        columns = 3
        items = 10
        
        useEmptyLabel = false
        placeholder = "SpliTimer"
        
        saveTimers()
    }
}
