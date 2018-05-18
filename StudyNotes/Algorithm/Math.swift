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

func maxPairwiseProduct(numbers: [Int]) -> Int {
    var result = 0
    let n = numbers.count
    for i in 0..<n {
        for j in (i + 1)..<n {
            if numbers[i] * numbers[j] > result {
                result = numbers[i] * numbers[j]
            }
        }
    }
    return result
}

func maxPairwiseProductFast(numbers: [Int]) -> Int {
    let n = numbers.count
    var max_index1 = -1
    for i in 0..<n {
        if (max_index1 == -1) || (numbers[i] > numbers[max_index1]) {
            max_index1 = i
        }
    }
    var max_index2 = -1
    for j in 0..<n {
        if (j != max_index1 && ((max_index2 == -1) || numbers[j] > numbers[max_index2])) {
            max_index2 = j
        }
    }
    return numbers[max_index1] * numbers[max_index2]
}

func fibRecurs(n: Int) -> Int {
    if n <= 1 {
        return n
    } else {
        return fibRecurs(n: n - 1) + fibRecurs(n: n - 2)
    }
}

func fibList(n: Int) -> Int {
    
    var f = [Int](repeating: 0, count: n + 1)
    f[0] = 0
    if n > 0 {
        f[1] = 1
    }
    if n > 1 {
        for i in 2...n {
            f[i] = f[i - 1] + f[i - 2]
        }
    }
    return f[n]
}

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
