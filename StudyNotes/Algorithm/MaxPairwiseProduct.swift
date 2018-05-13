//
//  MaxPairwiseProduct.swift
//  Algorithm
//
//  Created by 朱双泉 on 2018/5/13.
//  Copyright © 2018 Castie!. All rights reserved.
//

import Foundation

@discardableResult func maxPairwiseProduct(numbers: [Int]) -> Int {
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

@discardableResult func maxPairwiseProductFast(numbers: [Int]) -> Int {
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
