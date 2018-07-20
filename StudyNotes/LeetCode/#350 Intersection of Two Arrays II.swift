//
//  #350 Intersection of Two Arrays II.swift
//  LeetCode
//
//  Created by 朱双泉 on 2018/7/20.
//  Copyright © 2018 Castie!. All rights reserved.
//

import Foundation

/*
 Given two arrays, write a function to compute their intersection.
 
 Example:
 Given nums1 = [1, 2, 2, 1], nums2 = [2, 2], return [2, 2].
 
 Note:
 Each element in the result should appear as many times as it shows in both arrays.
 The result can be in any order.
 Follow up:
 What if the given array is already sorted? How would you optimize your algorithm?
 What if nums1's size is small compared to nums2's size? Which algorithm is better?
 What if elements of nums2 are stored on disk, and the memory is limited such that you cannot load all elements into the memory at once?
 */

func intersect(_ nums1: [Int], _ nums2: [Int]) -> [Int] {

    var record = [Int : Int]()
    for i in 0..<nums1.count {
        if record[nums1[i]] == nil {
            record.updateValue(1, forKey: nums1[i])
        } else {
            record[nums1[i]]! += 1
        }
    }
    var resultArr = [Int]()
    for i in 0..<nums2.count {
        if record[nums2[i]] != nil, record[nums2[i]]! > 0 {
            resultArr.append(nums2[i])
            record[nums2[i]]! -= 1
        }
    }
    return resultArr
}
