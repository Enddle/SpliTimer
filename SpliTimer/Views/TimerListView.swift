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
                
                self.showAddItemButton()
            }
        }
    }
    
    func buildTimerView(_ n: Int) -> AnyView {
        if (timerVM.timers.indices ~= n) {
            if !timerVM.timers[n].isRemoved {
                return AnyView(ItemTimerView(timer: $timerVM.timers[n]))
            }
        }
        return AnyView(EmptyView())
    }
    
    func deleteTimerView(at offsets: IndexSet) {
        if offsets.count == 1 {
            timerVM.removeTimer(index: offsets.first!)
        }
    }
    
    func showAddItemButton() -> AnyView {
        if self.timerVM.canAddItemTimer {
            return AnyView(
                Button (action: {
                    self.timerVM.addTimer(isList: true)
                }) {
                    HStack {
                        Spacer()
                        Image(systemName: "plus")
                            .font(.title)
                            .foregroundColor(Color(.secondaryLabel))
                        Spacer()
                    }.padding()
                })
        }
        return AnyView(EmptyView())
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        TimerListView()
    }
}
