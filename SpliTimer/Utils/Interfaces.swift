//
//  Interfaces.swift
//
//  Created by Enddle Zheng on 5/21/18.
//  Copyright © 2018 Enddle Zheng. All rights reserved.
//

import Foundation
import SpriteKit
import UIKit


/**
 Present a web-type simple alert, supported: UIViewController, SKScene.
 
 - returns:
 viewIsSupported: Bool
 
 - parameters:
    - view: self
    - message: alert message
    - title: alert title, using application name by default
    - ok: alert button text
    - cancel: no cancel button by default
 */

@discardableResult public func alert(_ view: NSObject,_ message: String,
                                     title: String? = nil, ok: String = "OK", cancel: String? = nil) -> Bool {
    
    let t: String = title != nil ? title! : (Bundle.main.infoDictionary![kCFBundleNameKey as String] as? String)!
    let alertController = UIAlertController(title: t, message: message, preferredStyle: .alert)
    
    alertController.addAction(UIAlertAction(title: ok, style: .default, handler: nil))
    if cancel != nil { alertController.addAction(UIAlertAction(title: cancel, style: .cancel, handler: nil)) }
    
    var viewController: UIViewController
    if view.isKind(of: UIViewController.self) {
        viewController = view as! UIViewController
    } else if view.isKind(of: SKScene.self) {
        let scene = view as! SKScene
        viewController = (scene.view?.window?.rootViewController)!
    } else { return false }
    
    viewController.present(alertController, animated: true, completion: nil)
    return true
}
