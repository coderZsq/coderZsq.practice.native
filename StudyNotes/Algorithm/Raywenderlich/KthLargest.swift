//
//  KthLargest.swift
//  Algorithm
//
//  Created by 朱双泉 on 2018/5/23.
//  Copyright © 2018 Castie!. All rights reserved.
//

import Foundation

//nlogn
func kthLargest(a: [Int], k: Int) -> Int? {
    let len = a.count
    if k > 0 && k <= len {
        let sorted = a.sorted()
        return sorted[len - k]
    } else {
        return nil
    }
}

