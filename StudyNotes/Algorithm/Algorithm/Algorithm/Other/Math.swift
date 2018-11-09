//
//  Math.swift
//  Algorithm
//
//  Created by 朱双泉 on 2018/4/13.
//  Copyright © 2018 Castie!. All rights reserved.
//

import Foundation

func _pow_1(_ base: Int, _ exponent: Int) -> Int {

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

func _pow_2(_ base: Double, _ exponent: Int) -> Double {
    
    if exponent < 0 {
        return 0
    }
    if exponent == 0 {
        return 0
    }
    var ans:Double = 1, last_pow = base, exp = exponent
    
    while exp > 0 {
        if (exp & 1) != 0 {
            ans = ans * last_pow
        }
        exp = exp >> 1
        last_pow = last_pow * last_pow
    }
    return ans
}

func _pow_3(_ base: Double, _ exponent: Int) -> Double {

    var isNegative = false
    var exp = exponent
    if exp < 0 {
        isNegative = true
        exp = -exp
    }
    let result = _pow_2(base, exp)
    return isNegative ? 1 / result : result
}
