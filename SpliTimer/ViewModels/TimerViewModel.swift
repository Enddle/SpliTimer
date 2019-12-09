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
    
    var mainTime: Int = 0 { didSet {didChange.send()} }
    
    let rows = 2
    let columns = 3
    
    @Published var timers: [CircleTimer] = [
        CircleTimer(id: 0, label: "Label 1")
    ]
    
    @Published var buttons: [ControlButton] = [
        ControlButton(id: 0, icon: "arrow.clockwise", color: Color(.systemGray3), color2: Color(.systemGray)),
        ControlButton(id: 1, icon: "plus", color: Color(.systemGray), color2: Color(.systemGray3)),
        ControlButton(id: 2, icon: "play.fill", color: Color(.systemGreen), icon2: "stop.fill", color2: Color(.systemRed))
    ]
    
    let didChange = PassthroughSubject<Void, Never>()
    
    func buttonTapped(id: Int) {
        
        if id == 2 {  // Start button

            if buttons[2].mainState {
                buttons[0].mainState = false
                buttons[2].mainState = false
            } else {
                buttons[2].mainState = true
            }
        } else if id == 1 {  // Add button
            
            let count = timers.count
            if count >= rows * columns { return }
                
            timers.append(CircleTimer(id: count, label: "Label \(count + 1)"))
            if count == rows * columns - 1 {
                buttons[1].mainState = false
            }
        } else if id == 0 {  // Reset button
            
            if !buttons[0].mainState {
                buttons[0].mainState = true
                buttons[2].mainState = true
            }
        }
    }
    
    func timerTapped(id: Int) {
        
        for timer in timers {
            if timer.id == id {
                timers[id].isTiming.toggle()
            } else {
                timers[timer.id].isTiming = false
            }
        }
    }
}
