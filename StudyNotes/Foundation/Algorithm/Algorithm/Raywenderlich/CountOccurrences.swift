//
//  CountOccurrences.swift
//  Algorithm
//
//  Created by 朱双泉 on 2018/5/23.
//  Copyright © 2018 Castie!. All rights reserved.
//

import Foundation

//logn
func countOccurrenceOfKey(_ key: Int, inArray a: [Int]) -> Int {
    func leftBoundary() -> Int {
        var low = 0
        var high = a.count
        while low < high {
            let midIndex = low + (high - low) / 2
            if a[midIndex] < key {
                low = midIndex + 1
            } else {
                high = midIndex
            }
        }
        return low
    }
    
    func rightBoundary() -> Int {
        var low = 0
        var high = a.count
        while low < high {
            let midIndex = low + (high - low) / 2
            if a[midIndex] > key {
                high = midIndex
            } else {
                low = midIndex + 1
            }
        }
        return low
    }
    
    return rightBoundary() - leftBoundary()
}
