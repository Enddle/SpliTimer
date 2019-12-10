//
//  AppIconUtil.swift
//  SpliTimer
//
//  Created by Enddle Zheng on 12/9/19.
//  Copyright © 2019 Enddle Zheng. All rights reserved.
//

import UIKit

class AppIconUtil {
    
    let application = UIApplication.shared
    
    enum AppIcon: String {
        
        case reset
        case greyIcon
        case greyLineIcon
    }
    
    /**
     Change to an alternative AppIcon.
     
     - returns:
     Void
     
     - parameters:
         - icon: AppIcon enum
     */
    func changeAppIcon(_ icon: AppIcon) {
        
        application.setAlternateIconName(icon == AppIcon.reset ? nil : icon.rawValue)
    }
}
