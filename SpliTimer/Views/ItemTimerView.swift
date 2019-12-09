//
//  ItemTimerView.swift
//  SpliTimer
//
//  Created by Enddle Zheng on 12/9/19.
//  Copyright © 2019 Enddle Zheng. All rights reserved.
//

import SwiftUI

struct ItemTimerView: View {
    
    @Binding var timer: STSubTimer
    @EnvironmentObject var rootVM: TimerViewModel
    
    var body: some View {
        HStack {
            Text(timer.label)
                .font(.title)
                .foregroundColor(timer.isTiming ? Color(.label) : Color(.secondaryLabel))
            Spacer()

            Button (action: {
                self.rootVM.timerTapped(id: self.timer.id)
            }) {
                Text(timer.subTime.display3())
                    .font(Font.title.monospacedDigit())
                    .foregroundColor(timer.isTiming ? Color(.label) : Color(.secondaryLabel))
            }
        }.padding()
    }
}
