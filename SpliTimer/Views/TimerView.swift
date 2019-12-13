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
    @EnvironmentObject var appearance: AppearanceEnvironment
    
    var body: some View {
        
        GeometryReader { geometry in
            
            if geometry.size.height > self.appearance.minHeightForPortrait {

                VStack {
                    Text(self.timerVM.mainTime.display3())
                        .font(Font.system(size: 80).monospacedDigit())
                        .fontWeight(.ultraLight)
                        .padding(.top, 60)
                    
                    Spacer()
                    
                    VStack(spacing: 20) {
                        ForEach(0..<self.timerVM.rows) { i in
                            HStack(alignment: .center, spacing: 0) {
                                ForEach(0..<self.timerVM.columns) { j in
                                    self.buildTimerView(i, j)
                                }
                            }
                        }
                    }.padding()
                    
                    Spacer()
                    
                    HStack(alignment: .center) {
                        ResetButtonView(button: self.$timerVM.resetButton)
                        AddButtonView(button: self.$timerVM.addButton)
                        StartButtonView(button: self.$timerVM.startButton)
                    }.padding(.bottom, 60)
                    
                }
            } else {
                
                HStack {
                    
                    Text(self.timerVM.mainTime.display3())
                        .font(Font.system(size: 80).monospacedDigit())
                        .fontWeight(.ultraLight)
                    
                    VStack(spacing: 20) {
                        ForEach(0..<self.timerVM.rows) { i in
                            HStack(alignment: .center, spacing: 0) {
                                ForEach(0..<self.timerVM.columns) { j in
                                    self.buildTimerView(i, j)
                                }
                            }
                        }
                    }.padding()
                    
                    VStack {
                        ResetButtonView(button: self.$timerVM.resetButton)
                        AddButtonView(button: self.$timerVM.addButton)
                        StartButtonView(button: self.$timerVM.startButton)
                    }
                }
            }
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
