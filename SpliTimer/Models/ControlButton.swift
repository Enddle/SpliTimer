//
//  ControlButton.swift
//  SpliTimer
//
//  Created by Enddle Zheng on 12/8/19.
//  Copyright © 2019 Enddle Zheng. All rights reserved.
//

import SwiftUI

struct ControlButton: Identifiable {
    
    var id: Int
    var icon: String
    var color: Color
    var icon2: String
    var color2: Color
    
    var mainState = true
    
    init(id: Int, icon: String, color: Color, icon2: String? = nil, color2: Color? = nil) {
        self.id = id
        self.icon = icon
        self.color = color
        self.icon2 = icon2 ?? icon
        self.color2 = color2 ?? color
    }
}
