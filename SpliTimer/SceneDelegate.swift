//
//  SceneDelegate.swift
//  SpliTimer
//
//  Created by Enddle Zheng on 12/8/19.
//  Copyright © 2019 Enddle Zheng. All rights reserved.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var timerVM = TimerViewModel()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOpitions: UIScene.ConnectionOptions) {
        
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: ContentView().environmentObject(timerVM))
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}
