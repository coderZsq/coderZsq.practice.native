//
//  main.swift
//  LeetCode
//
//  Created by 朱双泉 on 2018/4/14.
//  Copyright © 2018 Castie!. All rights reserved.
//

import Foundation

/*
 Example:
 
 Given nums = [2, 7, 11, 15], target = 9,
 
 Because nums[0] + nums[1] = 2 + 7 = 9,
 return [0, 1].
 */

//MARK: - #1 Two Sum
scope(of: "#1 Two Sum", execute: true) {
    
    print(twoSum([2, 7, 11, 15], 9))
    
    let nums = randomList(10000000), target = randomNum(20000000)
    timing { twoSum(nums, target) }
    timing { twoSum_(nums, target) }
}
