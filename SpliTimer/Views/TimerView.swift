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
        VStack {
            Text(timerVM.mainTime.display3())
                .font(Font.system(size: 80).monospacedDigit())
                .fontWeight(.ultraLight)
                .padding(.top, 60)
            
            Spacer()
            
            VStack(spacing: 20) {
                ForEach(0..<timerVM.rows) { i in
                    HStack(alignment: .center, spacing: 0) {
                        ForEach(0..<self.timerVM.columns) { j in
                            self.buildTimerView(i, j)
                        }
                    }
                }
            }.padding()
            
            Spacer()
            
            HStack(alignment: .center) {
                ResetButtonView(button: $timerVM.resetButton)
                AddButtonView(button: $timerVM.addButton)
                StartButtonView(button: $timerVM.startButton)
            }.padding(.bottom, 60)
            
        }
    }
    
    func buildTimerView(_ i: Int, _ j: Int) -> AnyView {
        let n = 3 * i + j
        if (timerVM.timers.indices ~= n) {
            if !timerVM.timers[n].isRemoved {
                return AnyView(CircleTimerView(timer: $timerVM.timers[n]))
            }
        }
        return AnyView(EmptyView())
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
