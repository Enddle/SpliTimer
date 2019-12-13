//
//  AppearanceEnvironment .swift
//  SpliTimer
//
//  Created by Enddle Zheng on 12/12/19.
//  Copyright © 2019 Enddle Zheng. All rights reserved.
//

import UIKit
import SwiftUI
import Combine

class AppearanceEnvironment: ObservableObject {
    
    let notification = NotificationCenter.default
    
    @Published var keyboardInset = EdgeInsets()
    var safeArea = EdgeInsets()
    
    let minHeightForPortrait: CGFloat = 350
    @Published var layoutPortrait = true
    
    init() {
        notification.addObserver(self, selector: #selector(keyboardAdjust), name: UIResponder.keyboardWillHideNotification, object: nil)
        notification.addObserver(self, selector: #selector(keyboardAdjust), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc func keyboardAdjust(notification: Notification) {
        guard let keyboard = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }

        let keyboardFrame = keyboard.cgRectValue
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            self.keyboardInset = EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        } else {
            self.keyboardInset = EdgeInsets(top: 0, leading: 0, bottom: keyboardFrame.height - safeArea.bottom, trailing: 0)
        }
    }
    
    func geometryInfo(_ geometry: GeometryProxy) -> Bool {
        safeArea = geometry.safeAreaInsets
        return true
    }
}
