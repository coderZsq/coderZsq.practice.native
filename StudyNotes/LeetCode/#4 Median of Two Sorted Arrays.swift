//
//  #4 Median of Two Sorted Arrays.swift
//  LeetCode
//
//  Created by 朱双泉 on 2018/4/17.
//  Copyright © 2018 Castie!. All rights reserved.
//

import Foundation

/*
 There are two sorted arrays nums1 and nums2 of size m and n respectively.
 Find the median of the two sorted arrays. The overall run time complexity should be O(log (m+n)).
 
 Example 1:
 nums1 = [1, 3]
 nums2 = [2]
 
 The median is 2.0
 
 Example 2:
 nums1 = [1, 2]
 nums2 = [3, 4]
 
 The median is (2 + 3)/2 = 2.5
 */

@discardableResult func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
    
    if nums1.count == 0 {
        if nums2.count % 2 == 1 {
            return Double(nums2[nums2.count / 2])
        } else {
            return Double(nums2[nums2.count / 2] + nums2[nums2.count / 2 - 1]) * 0.5
        }
    } else if nums2.count == 0 {
        if nums1.count % 2 == 1 {
            return Double(nums1[nums1.count / 2])
        } else {
            return Double(nums1[nums1.count / 2] + nums1[nums1.count / 2 - 1]) * 0.5
        }
    }
    
    let total = nums1.count + nums2.count
    let count = nums1.count < nums2.count ? nums1.count : nums2.count
    let odd = total % 2 == 1
    
    var i = 0, j = 0, f = 1, m1 = 0.0, m2 = 0.0, result = 0.0;
    for _ in 0...count {
        if odd { nums1[i] < nums2[j] ? (i += 1) : (j += 1) }
        if f >= total / 2 {
            if odd {
                result = nums1[i] < nums2[j] ? Double(nums1[i]) : Double(nums2[j])
            } else {
                if nums1[i] < nums2[j] {
                    m1 = Double(nums1[i])
                    if (i + 1) < nums1.count && nums1[i + 1] < nums2[j] {
                        m2 = Double(nums1[i + 1])
                    } else {
                        m2 = Double(nums2[j])
                    }
                } else {
                    m1 = Double(nums2[j])
                    if (j + 1) < nums2.count && nums2[j + 1] < nums1[i] {
                        m2 = Double(nums2[j + 1])
                    } else {
                        m2 = Double(nums1[i])
                    }
                }
                result = (m1 + m2) * 0.5
            }
            break
        }
        if !odd { nums1[i] < nums2[j] ? (i += 1) : (j += 1) }
        f += 1
    }
    return result
}

@discardableResult func findMedianSortedArrays_(_ nums1: [Int], _ nums2: [Int]) -> Double {
    let m = nums1.count
    let n = nums2.count
    
    return (findKth(nums1, nums2, (m + n + 1) / 2) + findKth(nums1, nums2, (m + n + 2) / 2)) / 2
}

private func findKth(_ nums1: [Int], _ nums2: [Int], _ index: Int) -> Double {
    let m = nums1.count
    let n = nums2.count
    
    guard m <= n else {
        return findKth(nums2, nums1, index)
    }
    guard m != 0 else {
        return Double(nums2[index - 1])
    }
    guard index != 1 else {
        return Double(min(nums1[0], nums2[0]))
    }
    
    let i = min(index / 2, m)
    let j = min(index / 2, n)
    
    if nums1[i - 1] < nums2[j - 1] {
        return findKth(Array(nums1[i..<m]), nums2, index - i)
    } else {
        return findKth(nums1, Array(nums2[j..<n]), index - j)
    }
}

@discardableResult func findMedianSortedArrays__(_ nums1: [Int], _ nums2: [Int]) -> Double {
    
    let m = nums1.count
    let n = nums2.count
    
    if m > n {
        return findMedianSortedArrays(nums2, nums1)
    }
    
    let halfLength: Int = (m + n + 1) >> 1
    var b = 0, e = m
    var maxOfLeft = 0
    var minOfRight = 0
    
    while b <= e {
        let mid1 = (b + e) >> 1
        let mid2 = halfLength - mid1
        
        if mid1 > 0 && mid2 < n && nums1[mid1 - 1] > nums2[mid2] {
            e = mid1 - 1
        } else if mid2 > 0 && mid1 < m && nums1[mid1] < nums2[mid2 - 1] {
            b = mid1 + 1
        } else {
            if mid1 == 0 {
                maxOfLeft = nums2[mid2 - 1]
            } else if mid2 == 0 {
                maxOfLeft = nums1[mid1 - 1]
            } else {
                maxOfLeft = max(nums1[mid1 - 1], nums2[mid2 - 1])
            }
            
            if (m + n) % 2 == 1 {
                return Double(maxOfLeft)
            }
            
            if mid1 == m {
                minOfRight = nums2[mid2]
            } else if mid2 == n {
                minOfRight = nums1[mid1]
            } else {
                minOfRight = min(nums1[mid1], nums2[mid2])
            }
            
            break
        }
    }
    return Double(maxOfLeft + minOfRight) / 2.0
}

@discardableResult func findMedianSortedArrays___(_ array1: [Int], _ array2: [Int]) -> Double {
    
    let c1 = array1.count, c2 = array2.count
    var a1 = array1, a2 = array2
    if c1 <= 0 && c2 <= 0 {
        return 0.0
    }
    
    func findKth(_ nums1: inout [Int], i: Int, _ nums2: inout [Int], j: Int, k: Int) -> Double {
        if nums1.count - i > nums2.count - j {
            return findKth(&nums2, i: j, &nums1, j: i, k: k)
        }
        if nums1.count == i {
            return Double(nums2[j + k - 1])
        }
        if k == 1 {
            return Double(min(nums1[i], nums2[j]))
        }
        let pa = min(i + k / 2, nums1.count), pb = j + k - pa + i
        if nums1[pa - 1] < nums2[pb - 1] {
            return findKth(&nums1, i: pa, &nums2, j: j, k: k - pa + i)
        } else if nums1[pa - 1] > nums2[pb - 1] {
            return findKth(&nums1, i: i, &nums2, j: pb, k: k - pb + j)
        } else {
            return Double(nums1[pa - 1])
        }
    }
    
    let total = c1 + c2
    if total % 2 == 1 {
        return findKth(&a1, i: 0, &a2, j: 0, k: total / 2 + 1)
    } else {
        return (findKth(&a1, i: 0, &a2, j: 0, k: total / 2) + findKth(&a1, i: 0, &a2, j: 0, k: total / 2 + 1)) / 2.0
    }
}
