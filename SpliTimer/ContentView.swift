//
//  ContentView.swift
//  SpliTimer
//
//  Created by Enddle Zheng on 12/9/19.
//  Copyright © 2019 Enddle Zheng. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var selected: Int = 0
    
    var body: some View {
        TabView (selection: $selected) {
            
            TimerView().tabItem({
                Image(systemName: "timer")
                Text("Timer")
            }).tag(0)
            
            TimerListView().tabItem({
                Image(systemName: "list.bullet")
                Text("List")
            }).tag(1)
            
            SettingsView().tabItem({
                Image(systemName: "gear")
                Text("Settings")
            }).tag(2)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
