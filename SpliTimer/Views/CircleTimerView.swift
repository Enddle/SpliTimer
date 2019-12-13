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
    
    @State private var disableEdit: Bool = true
    
    var body: some View {
        VStack(spacing: 10) {
            
            Button(action: {
                self.rootVM.timerTapped(id: self.timer.id)
            }) {
                Text(timer.subTime.display2())
                    .font(Font.body.monospacedDigit())
                    .foregroundColor(timer.isTiming ? Color(.label) : Color(.secondaryLabel))
                    .padding(28)
                    .background(Circle().fill(timer.isTiming ? Color(.systemGray4) : Color(.systemGray6)))
                    .padding(3)
                    .overlay(Circle().stroke(timer.isTiming ? Color(.systemGray4) : Color(.systemGray6), lineWidth: 2))
            }
            .frame(width: 110, height: 110)
            
            TextField("Timer Name", text: $timer.label, onCommit: {
                self.disableEdit = true
            })
                .font(.body).multilineTextAlignment(.center)
                .foregroundColor(timer.isTiming ? Color(.label) : Color(.secondaryLabel))
                .disableAutocorrection(true)
                .disabled(disableEdit)
                .onTapGesture {
                    self.disableEdit = false
                    self.rootVM.haptic.selection()
            }
            
        }
    }
}
