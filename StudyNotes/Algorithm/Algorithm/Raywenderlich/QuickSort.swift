//
//  QuickSort.swift
//  Algorithm
//
//  Created by 朱双泉 on 2018/5/24.
//  Copyright © 2018 Castie!. All rights reserved.
//

import Foundation

func quickSort<T: Comparable>(_ a: [T]) -> [T] {
    guard a.count > 1 else { return a }
    
    let pivot = a[a.count / 2]
    let less = a.filter { $0 < pivot }
    let equal = a.filter { $0 == pivot }
    let greater = a.filter { $0 > pivot }
    
    return quickSort(less) + equal + quickSort(greater)
}

func partitionLomuto<T: Comparable>(_ a: inout [T], low: Int, high: Int) -> Int {
    let pivot = a[high]
    
    var i = low
    for j in low..<high {
        if a[j] <= pivot {
            (a[i], a[j]) = (a[j], a[i])
            i += 1
        }
    }
    
    (a[i], a[high]) = (a[high], a[i])
    return i
}

public func quickSortLomuto<T: Comparable>(_ a: inout [T], low: Int, high: Int) {
    if low < high {
        let p = partitionLomuto(&a, low: low, high: high)
        quickSortLomuto(&a, low: low, high: p - 1)
        quickSortLomuto(&a, low: p + 1, high: high)
    }
}

func partitionHoare<T: Comparable>(_ a: inout [T], low: Int, high: Int) -> Int {
    let pivot = a[low]
    var i = low - 1
    var j = high + 1
    
    while true {
        repeat { j -= 1 } while a[j] > pivot
        repeat { i += 1 } while a[i] < pivot
    
        if i < j {
            a.swapAt(i, j)
        } else {
            return j
        }
    }
}

func quickSortHoare<T: Comparable>(_ a: inout [T], low: Int, high: Int) {
    if low < high {
        let p = partitionHoare(&a, low: low, high: high)
        quickSortHoare(&a, low: low, high: p)
        quickSortHoare(&a, low: p + 1, high: high)
    }
}

func quickSortRandom<T: Comparable>(_ a: inout [T], low: Int, high: Int) {
    if low < high {
        let pivotIndex = random(min: low, max: high)
        
        (a[pivotIndex], a[high]) = (a[high], a[pivotIndex])
        
        let p = partitionLomuto(&a, low: low, high: high)
        quickSortRandom(&a, low: low, high: p - 1)
        quickSortRandom(&a, low: p + 1, high: high)
    }
}

func partitionDutchFlag<T: Comparable>(_ a: inout [T], low: Int, high: Int, pivotIndex: Int) -> (Int, Int) {
    let pivot = a[pivotIndex]
    
    var smaller = low
    var equal = low
    var larger = high
    
    while equal <= larger {
        if a[equal] < pivot {
            a.swapAt(smaller, equal)
            smaller += 1
            equal += 1
        } else if a[equal] == pivot {
            equal += 1
        } else {
            a.swapAt(equal, larger)
            larger -= 1
        }
    }
    return (smaller, larger)
}

func quickSortDutchFlag<T: Comparable>(_ a: inout [T], low: Int, high: Int) {
    if low < high {
        let pivotIndex = random(min: low, max: high)
        let (p, q) = partitionDutchFlag(&a, low: low, high: high, pivotIndex: pivotIndex)
        quickSortDutchFlag(&a, low: low, high: p - 1)
        quickSortDutchFlag(&a, low: q + 1, high: high)
    }
}



