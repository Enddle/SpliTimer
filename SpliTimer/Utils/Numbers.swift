//
//  Numbers.swift
//
//  Created by Enddle Zheng on 5/22/18.
//  Copyright © 2018 Enddle Zheng. All rights reserved.
//

import Foundation


extension Comparable {
    
    /**
     Tells if the numbers (strings, etc.) in the interval.
     
     - returns:
     isBetween: Bool
     
     - parameters:
         - a: can be min or max
         - b: can be min or max
         - closedInterval: use close interval, false by default
     */
    
    func isBetween<T: Comparable>(_ a: T, _ b: T, _ closeInterval: Bool = false) -> Bool {
        
        let n: T = self as! T
        let min = a < b ? a : b
        let max = b > a ? b : a
        
        return closeInterval ? n >= min && n <= max : n > min && n < max
    }
}


extension Int {
    
    func toShortString() -> String {
        
        return
            self < 1000 ? "\(self)" :
            self < 100000 ? "\(roundTo(Double(self) / 1000.0, digit: 1))k" :
            self < 1000000 ? "\(round(Double(self) / 1000.0))k" :
            self < 100000000 ? "\(roundTo(Double(self) / 1000000.0, digit: 1))m" :
            self < 1000000000 ? "\(round(Double(self) / 1000000.0))m" :
            "\(self / 1000000000)b"
    }
}


func roundTo(_ n: Double, digit: Int = 0) -> Double {
    
    let times = Double(truncating: pow(10, digit) as NSNumber)
    
    return round(n * times) / times
}



