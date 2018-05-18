//
//  MinRefills.swift
//  Algorithm
//
//  Created by 朱双泉 on 2018/5/18.
//  Copyright © 2018 Castie!. All rights reserved.
//

import Foundation

func minRefills(x: [Int], n: Int, L: Int) -> Int? {
    
    var numRefills = 0
    var currentRefill = 0
    var lastRefill = 0
    while currentRefill <= n {
        lastRefill = currentRefill
        while currentRefill <= n && x[currentRefill + 1] - x[lastRefill] <= L {
            currentRefill = currentRefill + 1
            if currentRefill + 1 == n {break}
        }
        if currentRefill == lastRefill {
            return nil
        }
        if currentRefill < n {
            numRefills = numRefills + 1
            if currentRefill + 1 == n {break}
        }
    }
    return numRefills
}
