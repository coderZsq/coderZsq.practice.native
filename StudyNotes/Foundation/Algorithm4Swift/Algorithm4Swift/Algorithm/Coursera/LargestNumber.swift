//
//  LargestNumber.swift
//  Algorithm
//
//  Created by 朱双泉 on 2018/5/18.
//  Copyright © 2018 Castie!. All rights reserved.
//

import Foundation

func largestNumber(_ input: [Int]) -> [Int] {
    
    var numbers = input
    var (maxIndex, maxValue) = (0, 0)
    for (index, value) in numbers.enumerated() {
        if value > maxValue {
            maxValue = value
            maxIndex = index
        }
    }
    guard numbers.count > 0 else { return [] }
    numbers.remove(at: maxIndex)
    return [maxValue] + largestNumber(numbers)
}
