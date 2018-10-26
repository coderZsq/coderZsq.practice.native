//
//  #26 Remove Duplicates from Sorted Array.swift
//  LeetCode
//
//  Created by 朱双泉 on 2018/10/26.
//  Copyright © 2018 Castie!. All rights reserved.
//

import Foundation

/*
 Example 1:
 
 Given nums = [1,1,2],
 
 Your function should return length = 2, with the first two elements of nums being 1 and 2 respectively.
 
 It doesn't matter what you leave beyond the returned length.
 Example 2:
 
 Given nums = [0,0,1,1,1,2,2,3,3,4],
 
 Your function should return length = 5, with the first five elements of nums being modified to 0, 1, 2, 3, and 4 respectively.
 
 It doesn't matter what values are set beyond the returned length.
 */

func removeDuplicates(nums: inout [Int]) -> Int {
    var set: Set<Int> = Set()
    for i in 0..<nums.count {
        set.insert(nums[i])
    }
    nums = Array(set);
    return set.count
}

func removeDuplicates_(nums: inout [Int]) -> Int {
    assert(nums.count > 0)
    var j = 1
    for i in 0..<nums.count {
        if i + 1 >= nums.count {
            break
        }
        if nums[i] < nums[i + 1] {
            nums[j] = nums[i + 1]
            j += 1
        }
    }
    return j
}
