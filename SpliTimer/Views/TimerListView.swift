//
//  TimerListView.swift
//  SpliTimer
//
//  Created by Enddle Zheng on 12/9/19.
//  Copyright © 2019 Enddle Zheng. All rights reserved.
//

import SwiftUI

struct TimerListView: View {
    
    @EnvironmentObject var timerVM: TimerViewModel
    
    var body: some View {
        
        let mainTap = TapGesture()
            .onEnded({ _ in
                self.timerVM.startTimer()
            })
        
        let mainHold = LongPressGesture(minimumDuration: 0.5)
            .onEnded({ _ in
                self.timerVM.resetTimer()
            })
        
        return List {
            HStack {
                Spacer()
                Text(timerVM.mainTime.display3())
                    .font(Font.largeTitle.monospacedDigit())
            }.padding()
            .gesture(mainTap)
            .gesture(mainHold)
            
            ForEach(0..<timerVM.items) { n in
                self.buildTimerView(n)
            }
            
            Button (action: {
                self.timerVM.addTimer(isList: true)
            }) {
                HStack {
                    Spacer()
                    Image(systemName: "plus")
                        .font(.title)
                        .foregroundColor(timerVM.canAddItemTimer ? Color(.secondaryLabel) : Color(.quaternaryLabel))
                    Spacer()
                }.padding()
            }
        }
    }
    
    func buildTimerView(_ n: Int) -> AnyView {
        if (n < timerVM.timers.count) {
            return AnyView(ItemTimerView(timer: $timerVM.timers[n]))
        }
        return AnyView(EmptyView())
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        TimerListView()
    }
}
