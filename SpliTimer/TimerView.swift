//
//  TimerView.swift
//  SpliTimer
//
//  Created by Enddle Zheng on 12/8/19.
//  Copyright © 2019 Enddle Zheng. All rights reserved.
//

import SwiftUI

struct TimerView: View {
    
    @ObservedObject var timerVM = TimerViewModel()
    
    var body: some View {
        VStack(spacing: 80) {
            Text("00:00.\(timerVM.mainTime)")
                .font(.largeTitle)
            
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
                ResetButtonView(button: $timerVM.resetButton, rootVM: timerVM)
                AddButtonView(button: $timerVM.addButton, rootVM: timerVM)
                StartButtonView(button: $timerVM.startButton, rootVM: timerVM)
            }
            
        }.padding()
    }
    
    func buildTimerView(_ i: Int, _ j: Int) -> AnyView {
        let n = 3 * i + j
        if (n < timerVM.timers.count) {
            return AnyView(CircleTimerView(timer: $timerVM.timers[n], rootVM: self.timerVM))
        }
        return AnyView(EmptyView())
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
