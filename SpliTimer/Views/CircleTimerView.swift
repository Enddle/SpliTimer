//
//  CircleTimerView.swift
//  SpliTimer
//
//  Created by Enddle Zheng on 12/8/19.
//  Copyright © 2019 Enddle Zheng. All rights reserved.
//

import SwiftUI

struct CircleTimerView: View {
    
    @Binding var timer: STSubTimer
    @EnvironmentObject var rootVM: TimerViewModel
    
    var body: some View {
        VStack(spacing: 10) {
            
            Button(action: {
                self.rootVM.timerTapped(id: self.timer.id)
            }) {
                Text(timer.subTime.display2())
                    .font(Font.body.monospacedDigit())
                    .foregroundColor(timer.isTiming ? Color(.label) : Color(.secondaryLabel))
                    .padding(28)
                    .background(Circle().fill(timer.isTiming ? Color(.systemGray) : Color(.systemGray5)))
                    .padding(3)
                    .overlay(Circle().stroke(timer.isTiming ? Color(.systemGray) : Color(.systemGray5), lineWidth: 2))
            }
            
            Text(timer.label)
                .font(.body).foregroundColor(timer.isTiming ? Color(.label) : Color(.secondaryLabel))
        }
    }
}
