//
//  #283 Move Zeros.swift
//  LeetCode
//
//  Created by 朱双泉 on 2018/7/18.
//  Copyright © 2018 Castie!. All rights reserved.
//

import Foundation

/*
Given an array nums, write a function to move all 0's to the end of it while maintaining the relative order of the non-zero elements.

Example:

Input: [0,1,0,3,12]
Output: [1,3,12,0,0]
Note:

1. You must do this in-place without making a copy of the array.
2. Minimize the total number of operations.
*/

func moveZeroes(_ nums: inout [Int]) {
    var nonZeroElements = [Int]()
    for i in 0..<nums.count {
        if nums[i] != 0 {
            nonZeroElements.append(nums[i])
        }
    }
    for i in 0..<nonZeroElements.count {
        nums[i] = nonZeroElements[i];
    }
    for i in nonZeroElements.count..<nums.count {
        nums[i] = 0
    }
}

func moveZeroes_(_ nums: inout [Int]) {
    
    var k = 0 //nums中, [0...k)的元素均为非0元素
    //遍历到第i个元素后, 保证[0...i]中所有非0元素
    //都按照顺序排列在[0...k)中
    for i in 0..<nums.count {
        if nums[i] != 0 {
            nums[k] = nums[i]
            k += 1
        }
    }
    //将nums剩余的位置放置为0
    for i in k..<nums.count {
        nums[i] = 0
    }
}

func moveZeroes__(_ nums: inout [Int]) {
    
    var k = 0 //nums中, [0...k)的元素均为非0元素
    //遍历到第i个元素后, 保证[0...i]中所有非0元素
    //都按照顺序排列在[0...k)中
    //同时, [k...i]为0
    for i in 0..<nums.count {
        if nums[i] != 0 {
            if i != k {
                nums.swapAt(k, i)
            }
            k += 1
        }
    }
}
