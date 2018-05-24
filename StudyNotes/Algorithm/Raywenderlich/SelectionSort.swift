//
//  SelectionSort.swift
//  Algorithm
//
//  Created by 朱双泉 on 2018/5/24.
//  Copyright © 2018 Castie!. All rights reserved.
//

import Foundation

#if false
func selectionSort(_ array: [Int]) -> [Int] {
    guard array.count > 1 else { return array }
    
    var a = array
    
    for x in 0..<a.count - 1 {
        
        var lowest = x
        for y in x + 1..<a.count {
            if a[y] < a[lowest] {
                lowest = y
            }
        }
        
        if x != lowest {
            a.swapAt(x, lowest)
        }
    }
    return a
}
#endif

public func selectionSort<T: Comparable>(_ array: [T], _ isOrderedBefore: (T, T) -> Bool) -> [T] {
    guard array.count > 1 else { return array }
    
    var a = array
    for x in 0..<a.count - 1 {
        
        var lowest = x
        for y in x + 1..<a.count {
            if isOrderedBefore(a[y], a[lowest]) {
                lowest = y
            }
        }
        
        if x != lowest {
            a.swapAt(x, lowest)
        }
    }
    return a
}
