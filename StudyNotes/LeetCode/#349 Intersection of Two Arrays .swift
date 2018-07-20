//
//  #349 Intersection of Two Arrays .swift
//  LeetCode
//
//  Created by 朱双泉 on 2018/7/20.
//  Copyright © 2018 Castie!. All rights reserved.
//

import Foundation

/*
 Given two arrays, write a function to compute their intersection.
 
 Example:
 Given nums1 = [1, 2, 2, 1], nums2 = [2, 2], return [2].
 
 Note:
 Each element in the result must be unique.
 The result can be in any order.
 */

func intersection(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
    
    var record = Set<Int>()
    for i in 0..<nums1.count {
        record.insert(nums1[i])
    }
    var resultSet = Set<Int>()
    for i in 0..<nums2.count {
        if record.contains(nums2[i]) {
            resultSet.insert(nums2[i])
        }
    }
    var resultArr = [Int]()
    for num in resultSet {
        resultArr.append(num)
    }
    return resultArr
}
