//
//  CircleTimer.swift
//  SpliTimer
//
//  Created by Enddle Zheng on 12/8/19.
//  Copyright © 2019 Enddle Zheng. All rights reserved.
//

import SwiftUI

struct CircleTimer: Identifiable {
    
    var id: Int
    var label: String
    var isTiming: Bool
    
    var subTime = STTime()
    
    init(id: Int, label: String, isTiming: Bool = false) {
        self.id = id
        self.label = label
        self.isTiming = isTiming
    }
}
