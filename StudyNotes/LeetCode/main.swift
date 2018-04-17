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
scope(of: "#2 Add Two Numbers", execute:false) {
    
    let l1 = ListNode(2)
    l1.next = ListNode(4)
    l1.next?.next = ListNode(3)

    let l2 = ListNode(5)
    l2.next = ListNode(6)
    l2.next?.next = ListNode(4)
    addTwoNumbers_(l1, l2)?.printNode()
}

/*
 Examples:
 
 Given "abcabcbb", the answer is "abc", which the length is 3.
 Given "bbbbb", the answer is "b", with the length of 1.
 Given "pwwkew", the answer is "wke", with the length of 3. Note that the answer must be a substring, "pwke" is a subsequence and not a substring.
 */

//MARK: - #3 Longest Substring Without Repeating Characters
scope(of: "#3 Longest Substring Without Repeating Characters", execute: false) {

    print(lengthOfLongestSubstring("abcabcbb"))
    print(lengthOfLongestSubstring("bbbbb"))
    print(lengthOfLongestSubstring("pwwkew"))

    print(lengthOfLongestSubstring_("abcabcbb"))
    print(lengthOfLongestSubstring_("bbbbb"))
    print(lengthOfLongestSubstring_("pwwkew"))
    
    let str = randomString(1000000)
    timing { lengthOfLongestSubstring(str) }
    timing { lengthOfLongestSubstring_(str) }
}

/*
 Example 1:
 nums1 = [1, 3]
 nums2 = [2]
 
 The median is 2.0
 
 Example 2:
 nums1 = [1, 2]
 nums2 = [3, 4]
 
 The median is (2 + 3)/2 = 2.5
 */
//MARK: - #4 Median of Two Sorted Arrays

scope(of: "#4 Median of Two Sorted Arrays", execute: true) {
    
    print(findMedianSortedArrays([1, 3], [2]))
    print(findMedianSortedArrays_([1, 3], [2]))
    print(findMedianSortedArrays__([1, 3], [2]))

    print(findMedianSortedArrays([1, 2], [3, 4]))
    print(findMedianSortedArrays_([1, 2], [3, 4]))
    print(findMedianSortedArrays__([1, 2], [3, 4]))

    let array1 = randomList(10000).sorted()
    let array2 = randomList(10000).sorted()
    timing { findMedianSortedArrays(array1 ,array2) }
    timing { findMedianSortedArrays_(array1 ,array2) }
    timing { findMedianSortedArrays__(array1 ,array2) }
    timing { findMedianSortedArrays___(array1 ,array2) }

}
