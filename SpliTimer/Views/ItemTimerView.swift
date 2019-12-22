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
            buildText()
            
            Spacer()

            Button (action: {
                self.rootVM.timerTapped(id: self.timer.id)
            }) {
                Text(timer.subTime.display3())
                    .font(Font.title.monospacedDigit())
                    .fontWeight(timer.isTiming ? .regular : .light)
                    .foregroundColor(timer.isTiming ? Color(.label) : Color(.secondaryLabel))
            }
        }.padding()
    }
    
    func buildText() -> AnyView {
        if !disableEdit || self.timer.label.isEmpty {
            return AnyView(
                TextField("Timer Name", text: self.$timer.label, onCommit: {
                    self.disableEdit = !self.timer.label.isEmpty  // disable if not empty
                    self.rootVM.saveTimers()
                })
                    .font(.body)
                    .foregroundColor(timer.isTiming ? Color(.label) : Color(.secondaryLabel))
                    .disableAutocorrection(true)
                    .onTapGesture {
                        self.rootVM.haptic.selection()
                        
                        // Initialize state value for saved empty label (fix disabled when input)
                        if self.timer.label.isEmpty { self.disableEdit = false }
                }
            )
        } else {
            return AnyView(
                Text(self.timer.label)
                    .font(.body)
                    .foregroundColor(timer.isTiming ? Color(.label) : Color(.secondaryLabel))
                    .onTapGesture {
                        self.rootVM.haptic.selection()
                        self.disableEdit = false
                }
            )
        }
    }
}
