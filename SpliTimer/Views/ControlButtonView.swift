//
//  ControlButtonView.swift
//  SpliTimer
//
//  Created by Enddle Zheng on 12/8/19.
//  Copyright © 2019 Enddle Zheng. All rights reserved.
//

import SwiftUI

struct ControlButtonView: View {
    
    @Binding var button: ControlButton
    @ObservedObject var rootVM: TimerViewModel
    
    var body: some View {
        
        Button(action: {
            self.rootVM.buttonTapped(id: self.button.id)
        }) {
            Image(systemName: button.mainState ? button.icon : button.icon2)
                .foregroundColor(button.mainState ? button.color : button.color2)
                .padding(32)
                .background(Circle().fill(button.mainState ? button.color.opacity(0.2) : button.color2.opacity(0.2)))
                .padding(3)
                .overlay(Circle().stroke(button.mainState ? button.color.opacity(0.2) : button.color2.opacity(0.2), lineWidth: 2))
        }
    }
}
