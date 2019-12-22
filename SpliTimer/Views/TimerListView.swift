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
    @EnvironmentObject var appearance: AppearanceEnvironment
    
    var body: some View {
        
        let mainTap = TapGesture()
            .onEnded({ _ in
                self.timerVM.startTimer()
            })
        
        let mainHold = LongPressGesture(minimumDuration: 0.5)
            .onEnded({ _ in
                self.timerVM.resetTimers()
            })
        
        return VStack {
            HStack {
                Spacer()
                Text(timerVM.mainTime.display3())
                    .font(Font.system(size: 40).monospacedDigit())
                    .fontWeight(.thin)
                    .padding(.top, 20)
            }.padding([.horizontal])
            .gesture(mainTap)
            .gesture(mainHold)
            
            List {
                ForEach(0..<timerVM.items) { n in
                    self.buildTimerView(n)
                }
                .onDelete(perform: deleteTimerView)
                
                buildAddButton()
            }
            .padding(.bottom, self.appearance.keyboardSafeInset)
            .animation(.easeInOut)
        }
    }
    
    func buildTimerView(_ n: Int) -> AnyView {
        if (timerVM.timers.indices ~= n) {
            if !timerVM.timers[n].isRemoved {
                return AnyView(
                    ItemTimerView(timer: $timerVM.timers[n])
                        .animation(.none)
                )
            }
        }
        return AnyView(EmptyView())
    }
    
    func deleteTimerView(at offsets: IndexSet) {
        if offsets.count == 1 {
            timerVM.removeTimer(index: offsets.first!)
        }
    }
    
    func buildAddButton() -> AnyView {
        if self.timerVM.canAddItemTimer {
            return AnyView(AddItemButtonView())
        }
        return AnyView(EmptyView())
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        TimerListView()
    }
}
