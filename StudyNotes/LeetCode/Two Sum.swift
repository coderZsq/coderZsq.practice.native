//
//  Two Sum.swift
//  LeetCode
//
//  Created by 朱双泉 on 2018/4/14.
//  Copyright © 2018 Castie!. All rights reserved.
//

/*
 Given an array of integers, return indices of the two numbers such that they add up to a specific target.
 You may assume that each input would have exactly one solution, and you may not use the same element twice.
 
 Example:
 
 Given nums = [2, 7, 11, 15], target = 9,
 
 Because nums[0] + nums[1] = 2 + 7 = 9,
 return [0, 1].
 */

import Foundation

@discardableResult func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
    
    for x0 in 0..<nums.count {
        for x1 in (x0 + 1)..<nums.count {
            if (nums[x0] + nums[x1]) == target {
                return [x0, x1]
            }
        }
    }
    return []
}

@discardableResult func twoSum_(_ nums: [Int], _ target: Int) -> [Int] {
    
    var dict = [Int: Int]()
    for (i, num) in nums.enumerated() {
        if let lastIndex = dict[target - num] {
            return [lastIndex, i]
        }
        dict[num] = i
    }
    fatalError("No valid outputs")
}
