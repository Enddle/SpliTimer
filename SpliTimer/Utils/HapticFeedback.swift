//
//  HapticFeedback.swift
//  SpliTimer
//
//  Created by Enddle Zheng on 12/9/19.
//  Copyright © 2019 Enddle Zheng. All rights reserved.
//

import UIKit

class HapticFeedback {
    
    let notificationGenerator = UINotificationFeedbackGenerator()
    let selectGenerator = UISelectionFeedbackGenerator()
    
    func error() {
        notificationGenerator.notificationOccurred(.error)
    }
    
    func success() {
        notificationGenerator.notificationOccurred(.success)
    }
    
    func warning() {
        notificationGenerator.notificationOccurred(.warning)
    }
    
    func lightImpact() {
        let impactGenerator = UIImpactFeedbackGenerator(style: .light)
        impactGenerator.prepare()
        impactGenerator.impactOccurred()
    }
    
    func mediumImpact() {
        let impactGenerator = UIImpactFeedbackGenerator(style: .medium)
        impactGenerator.prepare()
        impactGenerator.impactOccurred()
    }
    
    func heavyImpact() {
        let impactGenerator = UIImpactFeedbackGenerator(style: .heavy)
        impactGenerator.prepare()
        impactGenerator.impactOccurred()
    }
    
    func selection() {
        selectGenerator.selectionChanged()
    }
}
