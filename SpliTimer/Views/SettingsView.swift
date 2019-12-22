//
//  SettingsView.swift
//  SpliTimer
//
//  Created by Enddle Zheng on 12/9/19.
//  Copyright © 2019 Enddle Zheng. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    
    let icon = AppIconUtil()
    @EnvironmentObject var timerVM: TimerViewModel
    
    @State var showRemoveAllAlert = false
    
    var body: some View {
        List {
            Button(action: {
                self.icon.changeAppIcon(.reset)
            }) {
                Text("Reset Icon")
            }
            
            Button(action: {
                self.icon.changeAppIcon(.greyIcon)
            }) {
                Text("Change to Grey Icon")
            }
            
            Button(action: {
                self.icon.changeAppIcon(.greyLineIcon)
            }) {
                Text("Change to Grey Line Icon")
            }
            
            Button(action: {
                UserDefaults.standard.set([], forKey: "SavedLabels")
            }) {
                Text("Clear Data")
            }
            
            Button(action: {
                self.showRemoveAllAlert = true
            }) {
                Text("Remove All Timers")
            }
            .alert(isPresented:$showRemoveAllAlert) {
                Alert(title: Text("Remove All Timers"), message: Text("This action cannot be undone"), primaryButton: .destructive(Text("Delete")) {
                        self.timerVM.removeAllTimers()
                }, secondaryButton: .cancel())
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
