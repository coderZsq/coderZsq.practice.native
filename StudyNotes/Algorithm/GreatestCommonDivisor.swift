//
//  GreatestCommonDivisor.swift
//  Algorithm
//
//  Created by 朱双泉 on 2018/5/18.
//  Copyright © 2018 Castie!. All rights reserved.
//

import Foundation

func naiveGCD(a: Int, b: Int) -> Int {
    
    var best = a
    for d in (1...best).reversed() {
        if (a % d) == 0 && (b % d) == 0 {
            break
        }
        best -= 1
    }
    return best
}

func euclidGCD(a: Int, b: Int) -> Int {
    
    if a % b == 0 {
        return b
    }
    let reminder = a % b
    return euclidGCD(a: b, b: reminder)
}
