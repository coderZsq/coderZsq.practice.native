//
//  Search.swift
//  Algorithm
//
//  Created by 朱双泉 on 26/02/2018.
//  Copyright © 2018 Castie!. All rights reserved.
//

import Foundation

@discardableResult func binSearch(list: [Int], find: Int) -> Int {

    var low = 0, high = list.count - 1
    while low <= high {
        let mid = (low + high) / 2
        if find == list[mid] {return mid}
        else if (find > list[mid]) {low = mid + 1}
        else {high = mid - 1}
    }
    return -1;
}

@discardableResult func recursiveBinSearch(list: [Int], find: Int) -> Int {
    
    func search(list: [Int], low: Int, high: Int, find: Int) -> Int {
        if low <= high {
            let mid = (low + high) / 2
            if find == list[mid] {return mid}
            else if (find > list[mid]) {
                return search(list: list, low: mid+1, high: high, find: find)
            }
            else {
                return search(list: list, low: low, high: mid-1, find: find)
            }
        }
        return -1;
    }
    return search(list: list, low: 0, high: list.count - 1, find: find)
}

func findingMedianOfTheSortedArrays(_ array1: [Double], _ array2: [Double]) -> Double {
    return 0
}


