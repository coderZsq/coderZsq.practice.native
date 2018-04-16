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
scope(of: "#1 Two Sum", execute: false) {
    
    print(twoSum_([2, 7, 11, 15], 9))
    
    let nums = randomList(10000000), target = randomNum(20000000)
    timing { twoSum(nums, target) }
    timing { twoSum_(nums, target) }
}

/*
 Example
 
 Input: (2 -> 4 -> 3) + (5 -> 6 -> 4)
 Output: 7 -> 0 -> 8
 Explanation: 342 + 465 = 807.
 */

//MARK: - #2 Add Two Numbers
scope(of: "#2 Add Two Numbers", execute:true) {
    
    let l1 = ListNode(2)
    l1.next = ListNode(4)
    l1.next?.next = ListNode(3)

    let l2 = ListNode(5)
    l2.next = ListNode(6)
    l2.next?.next = ListNode(4)
    addTwoNumbers_(l1: l1, l2)?.printNode()
}
