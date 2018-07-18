//
//  #75 Sort Colors.swift
//  LeetCode
//
//  Created by 朱双泉 on 2018/7/18.
//  Copyright © 2018 Castie!. All rights reserved.
//

import Foundation

/*
 Given an array with n objects colored red, white or blue, sort them in-place so that objects of the same color are adjacent, with the colors in the order red, white and blue.
 
 Here, we will use the integers 0, 1, and 2 to represent the color red, white, and blue respectively.
 
 Note: You are not suppose to use the library's sort function for this problem.
 
 Example:
 
 Input: [2,0,2,1,1,0]
 Output: [0,0,1,1,2,2]
 Follow up:
 
 A rather straight forward solution is a two-pass algorithm using counting sort.
 First, iterate the array counting number of 0's, 1's, and 2's, then overwrite array with total number of 0's, then 1's and followed by 2's.
 Could you come up with a one-pass algorithm using only constant space?
 */

func sortColors(_ nums: inout [Int]) {
    var count = [Int](repeating: 0, count: 3)
    for i in 0..<nums.count {
        assert(nums[i] >= 0 && nums[i] <= 2)
        count[nums[i]] += 1
    }
    var index = 0
    for _ in 0..<count[0] {
        nums[index] = 0
        index += 1
    }
    for _ in 0..<count[1] {
        nums[index] = 1
        index += 1
    }
    for _ in 0..<count[2] {
        nums[index] = 2
        index += 1
    }
}

func sortColors_(_ nums: inout [Int]) {
    var zero = -1
    var two = nums.count
    var i = 0
    for _ in 0..<two {
        if nums[i] == 1 {
            i += 1
        } else if nums[i] == 2 {
            two -= 1
            nums.swapAt(i, two)
        } else { //nums[i] == 0
            assert(nums[i] == 0)
            zero += 1
            nums.swapAt(zero, i)
            i += 1
        }
    }
}
