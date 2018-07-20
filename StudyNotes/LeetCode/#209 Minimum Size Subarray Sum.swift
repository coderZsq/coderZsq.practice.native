//
//  #209 Minimum Size Subarray Sum.swift
//  LeetCode
//
//  Created by 朱双泉 on 2018/7/20.
//  Copyright © 2018 Castie!. All rights reserved.
//

import Foundation

/*
 Given an array of n positive integers and a positive integer s, find the minimal length of a contiguous subarray of which the sum ≥ s. If there isn't one, return 0 instead.
 
 Example:
 
 Input: s = 7, nums = [2,3,1,2,4,3]
 Output: 2
 Explanation: the subarray [4,3] has the minimal length under the problem constraint.
 Follow up:
 If you have figured out the O(n) solution, try coding another solution of which the time complexity is O(n log n).
 */

func minSubArrayLen(_ s: Int, _ nums: [Int]) -> Int {
    var l = 0
    var r = -1
    var sum = 0
    var res = nums.count + 1
    while l < nums.count {
        if r + 1 < nums.count && sum < s {
            r += 1
            sum += nums[r]
        } else {
            sum -= nums[l]
            l += 1
        }
        if sum >= s {
            res = min(res, r - l + 1)
        }
    }
    if res == nums.count + 1 {
        return 0
    }
    return res
}
