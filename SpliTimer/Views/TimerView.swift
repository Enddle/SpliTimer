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
            
            if self.appearance.isLayoutPortrait(geometry) {

                VStack (alignment: .center) {
                    Spacer()
                    
                    Text(self.timerVM.mainTime.display3())
                        .font(Font.system(size: 80).monospacedDigit())
                        .fontWeight(.ultraLight)
                    
                    Spacer()
                    
                    VStack (alignment: .leading, spacing: 10) {
                        ForEach(0..<self.timerVM.rows) { i in
                            HStack (spacing: 0) {
                                ForEach(0..<self.timerVM.columns) { j in
                                    self.buildTimerView(i, j)
                                }
                            }
                        }
                    }
                    .padding(.bottom)
                    
                    Spacer()
                    
                    HStack {
                        Spacer()
                        ResetButtonView(button: self.$timerVM.resetButton)
                        AddButtonView(button: self.$timerVM.addButton)
                        StartButtonView(button: self.$timerVM.startButton)
                        Spacer()
                    }
                }
                .padding(.vertical)
            } else {
                
                HStack (alignment: .center) {
                    
                    Text(self.timerVM.mainTime.display3())
                        .font(Font.system(size: 80).monospacedDigit())
                        .fontWeight(.ultraLight)
                    
                    Spacer()
                    
                    VStack (alignment: .leading, spacing: 10) {
                        ForEach(0..<self.timerVM.rows) { i in
                            HStack (spacing: 0) {
                                ForEach(0..<self.timerVM.columns) { j in
                                    self.buildTimerView(i, j)
                                }
                            }
                        }
                    }
                    
                    Spacer()
                    
                    VStack {
                        Spacer()
                        StartButtonView(button: self.$timerVM.startButton)
                        AddButtonView(button: self.$timerVM.addButton)
                        ResetButtonView(button: self.$timerVM.resetButton)
                        Spacer()
                    }
                }
                .padding([.horizontal, .bottom])
            }
        }
    }
    
    func buildTimerView(_ i: Int, _ j: Int) -> AnyView {
        let n = timerVM.columns * i + j
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
