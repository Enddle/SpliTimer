//
//  TimerView.swift
//  SpliTimer
//
//  Created by Enddle Zheng on 12/8/19.
//  Copyright © 2019 Enddle Zheng. All rights reserved.
//

import SwiftUI

struct TimerView: View {
    
    @EnvironmentObject var timerVM: TimerViewModel
    
    var body: some View {
        VStack(spacing: 80) {
            Text(timerVM.mainTime.display3())
                .font(Font.largeTitle.monospacedDigit())
            
            VStack(spacing: 20) {
                ForEach(0..<timerVM.rows) { i in
                    HStack(alignment: .center, spacing: 0) {
                        ForEach(0..<self.timerVM.columns) { j in
                            self.buildTimerView(i, j)
                        }
                    }
                }
            }
            
            HStack(alignment: .center) {
                ResetButtonView(button: $timerVM.resetButton)
                AddButtonView(button: $timerVM.addButton)
                StartButtonView(button: $timerVM.startButton)
            }
            
        }.padding()
    }
    
    func buildTimerView(_ i: Int, _ j: Int) -> AnyView {
        let n = 3 * i + j
        if (n < timerVM.timers.count) {
            return AnyView(CircleTimerView(timer: $timerVM.timers[n]))
        }
        return AnyView(EmptyView())
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
