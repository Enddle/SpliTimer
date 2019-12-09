//
//  STTime.swift
//  SpliTimer
//
//  Created by Enddle Zheng on 12/9/19.
//  Copyright © 2019 Enddle Zheng. All rights reserved.
//

import Foundation
import Combine

struct STTime: Identifiable {
    
    var id = 0
    var raw: Int = 0
    var string: String = ""
    
    func display3() -> String {
        
        let mili = ("00" + String(raw)).suffix(2)
        let sec = ("00" + String(raw / 100 % 60)).suffix(2)
        let min = ("00" + String(raw / 6000)).suffix(2)
        return "\(min):\(sec).\(mili)"
    }
    
    func display2() -> String {
        
        let sec = ("00" + String(raw / 100 % 60)).suffix(2)
        let min = ("00" + String(raw / 6000)).suffix(2)
        return "\(min):\(sec)"
    }
}
