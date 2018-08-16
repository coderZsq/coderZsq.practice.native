//
//  #3 Longest Substring Without Repeating Characters.swift
//  LeetCode
//
//  Created by 朱双泉 on 2018/4/16.
//  Copyright © 2018 Castie!. All rights reserved.
//

import Foundation

/*
 Given a string, find the length of the longest substring without repeating characters.
 
 Examples:
 
 Given "abcabcbb", the answer is "abc", which the length is 3.
 Given "bbbbb", the answer is "b", with the length of 1.
 Given "pwwkew", the answer is "wke", with the length of 3. Note that the answer must be a substring, "pwke" is a subsequence and not a substring.
 */

@discardableResult func lengthOfLongestSubstring(_ s: String) -> Int {

    var arr = [Character]()
    var set = Set<Int>()
    
    for c in s {
        if arr.contains(c) {
            if arr.last == c {
                arr.removeAll()
            } else {
                for (idx, tc) in arr.enumerated() {
                    if tc == c {
                        for _ in 0..<idx +  1 {
                            arr.removeFirst()
                        }
                    }
                }
            }
        }
        arr.append(c)
        set.insert(arr.count)
    }
    return set.max() ?? 0
}

@discardableResult func lengthOfLongestSubstring_(_ s: String) -> Int {
    
    var left = 0, right = 0, substring = Set<Character>(), longest = 0
    let sChars = Array(s)
    
    while right < sChars.count {
        let currentChar = sChars[right]
        if substring.contains(currentChar) {
            longest = max(longest, right - left)
            substring.remove(sChars[left])
            left += 1
        } else {
            substring.insert(currentChar)
            right += 1            
            if right == sChars.count {
                longest = max(longest, right - left)
            }
        }
    }
    return longest
}
