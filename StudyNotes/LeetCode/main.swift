//
//  main.swift
//  LeetCode
//
//  Created by 朱双泉 on 2018/4/14.
//  Copyright © 2018 Castie!. All rights reserved.
//

import Foundation

//MARK: - #1 Two Sum
/*
 Example:
 
 Given nums = [2, 7, 11, 15], target = 9,
 
 Because nums[0] + nums[1] = 2 + 7 = 9,
 return [0, 1].
 */
scope(of: "#1 Two Sum", execute: false) {
    
    print(twoSum_([2, 7, 11, 15], 9))
    
    let nums = randomList(10000000), target = randomNum(20000000)
    timing { twoSum(nums, target) }
    timing { twoSum_(nums, target) }
}

//MARK: - #2 Add Two Numbers
/*
 Example
 
 Input: (2 -> 4 -> 3) + (5 -> 6 -> 4)
 Output: 7 -> 0 -> 8
 Explanation: 342 + 465 = 807.
 */
scope(of: "#2 Add Two Numbers", execute:false) {
    
    let l1 = ListNode(2)
    l1.next = ListNode(4)
    l1.next?.next = ListNode(3)

    let l2 = ListNode(5)
    l2.next = ListNode(6)
    l2.next?.next = ListNode(4)
    addTwoNumbers_(l1, l2)?.printNode()
}

//MARK: - #3 Longest Substring Without Repeating Characters
/*
 Examples:
 
 Given "abcabcbb", the answer is "abc", which the length is 3.
 Given "bbbbb", the answer is "b", with the length of 1.
 Given "pwwkew", the answer is "wke", with the length of 3. Note that the answer must be a substring, "pwke" is a subsequence and not a substring.
 */
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

//MARK: - #4 Median of Two Sorted Arrays
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
scope(of: "#4 Median of Two Sorted Arrays", execute: false) {
    
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

//MARK: - #27 Remove Element
/*
 Example 1:
 Given nums = [3,2,2,3], val = 3,
 Your function should return length = 2, with the first two elements of nums being 2.
 It doesn't matter what you leave beyond the returned length.
 
 Example 2:
 Given nums = [0,1,2,2,3,0,4,2], val = 2,
 Your function should return length = 5, with the first five elements of nums containing 0, 1, 3, 0, and 4.
 Note that the order of those five elements can be arbitrary.
 It doesn't matter what values are set beyond the returned length.
 */
scope(of: "#27 Remove Element", execute: false) {
    var nums = [3,2,2,3]
    let val = 3
    print(removeElement__(&nums, val))
    
    var nums2 = [0,1,2,2,3,0,4,2]
    let val2 = 2
    print(removeElement__(&nums2, val2))
    
    var randomArr = randomList(1000000)
    let num = randomNum(1, 1000)
    timing {removeElement(&randomArr, num)}
    timing {removeElement_(&randomArr, num)}
    timing {removeElement__(&randomArr, num)}
}

//MARK: - #75 Sort Colors
/*
 Example:
 
 Input: [2,0,2,1,1,0]
 Output: [0,0,1,1,2,2]
 */
scope(of: "#75 Sort Colors", execute: true) {
    var nums = [2,0,2,1,1,0]
    sortColors_(&nums)
    print(nums)
}

//MARK: - #283 Move Zeros
/*
 Example:
 
 Input: [0,1,0,3,12]
 Output: [1,3,12,0,0]
 */
scope(of: "#283 Move Zeros", execute: false) {
    
    var arr = [0, 1, 0, 3, 12]
    moveZeroes__(&arr)
    print(arr)
    
    var randomArr = randomList(1000000)
    timing {moveZeroes(&randomArr)}
    timing {moveZeroes_(&randomArr)}
    timing {moveZeroes__(&randomArr)}
}
