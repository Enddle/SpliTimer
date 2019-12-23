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
    @EnvironmentObject var appearance: AppearanceEnvironment
    
    @State var showRemoveAllAlert = false
    
    var body: some View {
        List {
            Section(){

                Button("Remove All Timers", action: {
                    self.showRemoveAllAlert = true
                })
                .alert(isPresented:$showRemoveAllAlert) {
                    Alert(title: Text("Remove All Timers"), message: Text("This action cannot be undone"), primaryButton: .destructive(Text("Delete")) {
                            self.timerVM.removeAllTimers()
                    }, secondaryButton: .cancel())
                }

                Button("Clear Data", action: {
                    UserDefaults.standard.set([], forKey: "SavedLabels")
                })
            }
            
            Section() {
                
                Stepper("Timer Rows: \(timerVM.rows)", value: $timerVM.rows, in: 1...5, onEditingChanged: { _ in
                    self.timerVM.saveSettings()
                })
                Stepper("Timer Columns: \(timerVM.columns)", value: $timerVM.columns, in: 1...5, onEditingChanged: { _ in
                    self.timerVM.saveSettings()
                })
                Stepper("Timer List Items: \(timerVM.items)", value: $timerVM.items, in: timerVM.rows*timerVM.columns...25, onEditingChanged: { _ in
                    self.timerVM.saveSettings()
                })
                
                Toggle("Create Empty Label", isOn: $timerVM.useEmptyLabel)
                    .onTapGesture {
                        self.timerVM.saveSettings()
                }
                
                HStack(alignment: .firstTextBaseline) {
                    Text("Placeholder Text")
                    Spacer()
                    TextField("Text", text: $timerVM.placeholder, onCommit: {
                        self.timerVM.saveSettings()
                    })
                        .multilineTextAlignment(.trailing)
                }
                .disabled(timerVM.useEmptyLabel)
                .foregroundColor(timerVM.useEmptyLabel ? Color(.secondaryLabel) : Color(.label))
                
                Button("Restore Settings", action: {
                    self.timerVM.restoreSettings()
                })
            }
            
            Section() {

                Button("Reset Icon", action: {
                    self.icon.changeAppIcon(.reset)
                })
                
                Button("Change to Grey Icon", action: {
                    self.icon.changeAppIcon(.greyIcon)
                })
                
                Button("Change to Grey Line Icon", action: {
                    self.icon.changeAppIcon(.greyLineIcon)
                })
            }
            
        }
        .listStyle(GroupedListStyle())
        .padding(.bottom, self.appearance.keyboardSafeInset)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
