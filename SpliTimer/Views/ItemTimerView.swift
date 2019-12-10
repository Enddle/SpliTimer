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
    
    @State private var disableEdit: Bool = true
    
    var body: some View {
        HStack {
            TextField("Timer Name", text: $timer.label, onCommit: {
                self.disableEdit = true
            })
                .font(.body)
                .foregroundColor(timer.isTiming ? Color(.label) : Color(.secondaryLabel))
                .disableAutocorrection(true)
                .disabled(disableEdit)
                .onTapGesture {
                    self.disableEdit = false
            }
            
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
