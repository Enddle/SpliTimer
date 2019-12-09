//
//  AddButtonView.swift
//  SpliTimer
//
//  Created by Enddle Zheng on 12/8/19.
//  Copyright © 2019 Enddle Zheng. All rights reserved.
//

import SwiftUI

struct AddButtonView: View {
    
    @Binding var button: ControlButton
    @ObservedObject var rootVM: TimerViewModel
    
    var body: some View {
        
        Button(action: {
            self.rootVM.addTimer()
        }) {
            Image(systemName: rootVM.canAddTimer ? button.icon : button.icon2)
                .foregroundColor(rootVM.canAddTimer ? button.color : button.color2)
                .padding(32)
                .background(Circle().fill(rootVM.canAddTimer ? button.color.opacity(0.2) : button.color2.opacity(0.2)))
                .padding(3)
                .overlay(Circle().stroke(rootVM.canAddTimer ? button.color.opacity(0.2) : button.color2.opacity(0.2), lineWidth: 2))
        }
    }
}
