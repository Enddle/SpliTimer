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
    
    @Published var keyboardSafeInset = CGFloat()
    var safeAreaInset = CGFloat()
    
    let minHeightForPortrait: CGFloat = 499.0  // iPhone SE (13.2) safe area height
    @Published var layoutPortrait = true
    
    let didChange = PassthroughSubject<Void, Never>()
    
    init() {
        notification.addObserver(self, selector: #selector(keyboardAdjust), name: UIResponder.keyboardWillHideNotification, object: nil)
        notification.addObserver(self, selector: #selector(keyboardAdjust), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc func keyboardAdjust(notification: Notification) {
        guard let keyboard = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }

        let keyboardFrame = keyboard.cgRectValue
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            self.keyboardSafeInset = 0
        } else {
            self.keyboardSafeInset = keyboardFrame.height - safeAreaInset
        }
    }
    
    /**
     Tells if the view should be layout in portrait mode, provide geometry infomation for the appearance model.
     
     - returns:
     isLayoutPortrait: Bool
     
     - parameters:
         - geometry: GeometryProxy of a view
     */
    
    func isLayoutPortrait(_ geometry: GeometryProxy) -> Bool {
        safeAreaInset = geometry.safeAreaInsets.bottom
        return geometry.size.height >= minHeightForPortrait
    }
}
