//
//  SettingsView.swift
//  SpliTimer
//
//  Created by Enddle Zheng on 12/9/19.
//  Copyright © 2019 Enddle Zheng. All rights reserved.
//

import SwiftUI
import MessageUI

struct SettingsView: View {
    
    let icon = AppIconUtil()
    @EnvironmentObject var timerVM: TimerViewModel
    @EnvironmentObject var appearance: AppearanceEnvironment
    
    @State var showRemoveAllAlert = false
    
    @State var result: Result<MFMailComposeResult, Error>? = nil
    @State var isShowingMailView = false
    @State var isShowingMailError = false
    
    var body: some View {
        ZStack {
            NavigationView {
                List {
                    Section(header: Text("Timer"), footer: Text("When adding a new timer, the label will be " + (timerVM.useEmptyLabel ? "empty." : timerVM.placeholder + " + id.") )) {
                        
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
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    self.timerVM.saveSettings()
                                }
                        }
                        
                        HStack(alignment: .firstTextBaseline) {
                            Text("Label Placeholder")
                            Spacer()
                            TextField("Text", text: $timerVM.placeholder, onCommit: {
                                self.timerVM.saveSettings()
                            })
                                .multilineTextAlignment(.trailing)
                        }
                        .disabled(timerVM.useEmptyLabel)
                        .foregroundColor(timerVM.useEmptyLabel ? Color(.secondaryLabel) : Color(.label))
                    }

                    Section(){

                        Button("Remove All Timers", action: {
                            self.showRemoveAllAlert = true
                        })
                        .alert(isPresented:$showRemoveAllAlert) {
                            Alert(title: Text("Remove All Timers"), message: Text("\nThis action cannot be undone"), primaryButton: .destructive(Text("Delete")) {
                                    self.timerVM.removeAllTimers()
                            }, secondaryButton: .cancel())
                        }

        //                Button("Clear Data", action: {
        //                    UserDefaults.standard.set([], forKey: "SavedLabels")
        //                })
                        
                        Button("Restore Settings", action: {
                            self.timerVM.restoreSettings()
                        })
                    }
                                
                    Section(header: Text("Icon")) {

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
                    
                    Section(header: Text("About")) {
                        VStack (alignment: .center) {
                            
                            Image("icon")
                                .resizable()
                                .frame(width: 80, height: 80)
                                .cornerRadius(18)
                            
                            Text("SpliTimer")
                                .font(.headline)
                                .padding()
                            
                            Text("Version: \(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "unknown")")
                                .font(.subheadline)
                                .padding()
                            
                            Text("Developer: Enddle Zheng")
                                .font(.subheadline)
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        
                        Button("Send Feedback Email", action: {
                            self.isShowingMailView.toggle()
                        })
                    }
                }
                .listStyle(GroupedListStyle())
                .padding(.bottom, self.appearance.keyboardSafeInset)
                .navigationBarTitle("Settings")
            }
            
            if (isShowingMailView) {
                mailView()
                    .transition(.move(edge: .bottom))
                    .animation(.default)
            }
        }
        .alert(isPresented: $isShowingMailError) {
            Alert(title: Text("Cannot Send Email"), message: Text("\nCan't send emails from this device"))
        }
    }

    private func mailView() -> some View {
        
        if !MFMailComposeViewController.canSendMail() {
            
            self.isShowingMailError = true
            return AnyView(EmptyView())
        }
        
        return AnyView(MailView(isShowing: $isShowingMailView, result: $result))
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
