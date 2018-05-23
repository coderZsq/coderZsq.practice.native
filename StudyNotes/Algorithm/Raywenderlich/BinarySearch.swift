//
//  BinarySearch.swift
//  Algorithm
//
//  Created by 朱双泉 on 2018/5/22.
//  Copyright © 2018 Castie!. All rights reserved.
//

import Foundation

//logn
func binarySearch<T: Comparable>(_ a: [T], key: T, range: Range<Int>) -> Int? {
    if range.lowerBound >= range.upperBound {
        return nil
    } else {
        let midIndex = range.lowerBound + (range.upperBound - range.lowerBound) / 2
        if a[midIndex] > key {
            return binarySearch(a, key: key, range: range.lowerBound..<midIndex)
        } else if a[midIndex] < key {
            return binarySearch(a, key: key, range: midIndex + 1..<range.upperBound)
        } else {
            return midIndex
        }
    }
}

func binarySearch<T: Comparable>(_ a: [T], key: T) -> Int? {
    var lowerBound = 0
    var upperBound = a.count
    while lowerBound < upperBound {
        let midIndex = lowerBound + (upperBound - lowerBound) / 2
        if a[midIndex] == key {
            return midIndex
        } else if a[midIndex] < key {
            lowerBound = midIndex + 1
        } else {
            upperBound = midIndex
        }
    }
    return nil
}
