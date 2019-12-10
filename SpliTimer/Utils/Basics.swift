//
//  Basics.swift
//  SpliTimer
//
//  Created by Enddle Zheng on 12/10/19.
//  Copyright © 2019 Enddle Zheng. All rights reserved.
//

import Foundation

extension Collection {
    func count(where test: (Element) throws -> Bool) rethrows -> Int {
        return try self.filter(test).count
    }
}
