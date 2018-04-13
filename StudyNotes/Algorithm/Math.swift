//
//  Math.swift
//  Algorithm
//
//  Created by 朱双泉 on 2018/4/13.
//  Copyright © 2018 Castie!. All rights reserved.
//

import Foundation

func mypow(_ base: Double, _ exponent: Int) -> Double {
    
    if exponent < 0 {
        return 0
    }
    
    if exponent == 0 {
        return 0
    }
    
    if exponent == 1 {
        return base
    }
    
    var result = base
    for _ in 1..<exponent {
        result *= base
    }
    return result
}




