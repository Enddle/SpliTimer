//
//  AddItemButtonView.swift
//  SpliTimer
//
//  Created by Enddle Zheng on 12/12/19.
//  Copyright © 2019 Enddle Zheng. All rights reserved.
//

import SwiftUI

struct AddItemButtonView: View {
    
    @EnvironmentObject var rootVM: TimerViewModel
    
    var body: some View {

        Button (action: {
            self.rootVM.addTimer(isList: true)
        }) {
            HStack {
                Spacer()
                Image(systemName: "plus")
                    .font(.title)
                    .foregroundColor(Color(.secondaryLabel))
                Spacer()
            }.padding()
        }
    }
}
