//
//  Search.swift
//  Algorithm
//
//  Created by 朱双泉 on 26/02/2018.
//  Copyright © 2018 Castie!. All rights reserved.
//

import Foundation

@discardableResult func binSearch(list: [Int], find: Int) -> Int {

    var low = 0, high = list.count - 1
    while low <= high {
        let mid = (low + high) / 2
        if find == list[mid] {return mid}
        else if (find > list[mid]) {low = mid + 1}
        else {high = mid - 1}
    }
    return -1;
}

@discardableResult func recursiveBinSearch(list: [Int], find: Int) -> Int {
    
    func search(list: [Int], low: Int, high: Int, find: Int) -> Int {
        if low <= high {
            let mid = (low + high) / 2
            if find == list[mid] {return mid}
            else if (find > list[mid]) {
                return search(list: list, low: mid+1, high: high, find: find)
            }
            else {
                return search(list: list, low: low, high: mid-1, find: find)
            }
        }
        return -1;
    }
    return search(list: list, low: 0, high: list.count - 1, find: find)
}

@discardableResult func findMedianSortedArrays_1(_ array1: [Int], _ array2: [Int]) -> Double {
    
    var array = [Int]()
    array.append(contentsOf: array1)
    array.append(contentsOf: array2)
    
    quickSort(list: &array)
    
    let b = array.count % 2
    let c = array.count
    var result = 0.0;
    if  b == 1  {
        result = Double(array[c / 2])
    } else {
        let n1 = array[c / 2 - 1]
        let n2 = array[c / 2]
        result = Double((n1 + n2)) / 2.0
    }
    
    return result
}

@discardableResult func findMedianSortedArrays_2(_ array1: [Int], _ array2: [Int]) -> Double {
    
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

@discardableResult func findMedianSortedArrays_3(_ array1: [Int], _ array2: [Int]) -> Double {
    
    if array1.count == 0 {
        if array2.count % 2 == 1 {
            return Double(array2[array2.count / 2])
        } else {
            return Double(array2[array2.count / 2] + array2[array2.count / 2 - 1]) * 0.5
        }
    } else if array2.count == 0 {
        if array1.count % 2 == 1 {
            return Double(array1[array1.count / 2])
        } else {
            return Double(array1[array1.count / 2] + array1[array1.count / 2 - 1]) * 0.5
        }
    }
    
    let total = array1.count + array2.count
    let index = total / 2
    let count = array1.count < array2.count ? array1.count : array2.count
    var array = [Int]()
    
    var i = 0, j = 0;
    for _ in 0...count {
        if array.count >= index + 1 {
            break
        }
        if array1[i] < array2[j] {
            array.append(array1[i])
            i += 1
        } else {
            array.append(array2[j])
            j += 1
        }
    }
    return total % 2 == 1 ? Double(array[index]) : Double(array[index] + array[index - 1]) * 0.5
}

@discardableResult func findMedianSortedArrays_4(_ array1: [Int], _ array2: [Int]) -> Double {
    
    if array1.count == 0 {
        if array2.count % 2 == 1 {
            return Double(array2[array2.count / 2])
        } else {
            return Double(array2[array2.count / 2] + array2[array2.count / 2 - 1]) * 0.5
        }
    } else if array2.count == 0 {
        if array1.count % 2 == 1 {
            return Double(array1[array1.count / 2])
        } else {
            return Double(array1[array1.count / 2] + array1[array1.count / 2 - 1]) * 0.5
        }
    }
    
    let total = array1.count + array2.count
    let count = array1.count < array2.count ? array1.count : array2.count
    let odd = total % 2 == 1
    
    var i = 0, j = 0, f = 1, m1 = 0.0, m2 = 0.0, result = 0.0;
    for _ in 0...count {
        if odd { array1[i] < array2[j] ? (i += 1) : (j += 1) }
        if f >= total / 2 {
            if odd {
                result = array1[i] < array2[j] ? Double(array1[i]) : Double(array2[j])
            } else {
                if array1[i] < array2[j] {
                    m1 = Double(array1[i])
                    if (i + 1) < array1.count && array1[i + 1] < array2[j] {
                        m2 = Double(array1[i + 1])
                    } else {
                        m2 = Double(array2[j])
                    }
                } else {
                    m1 = Double(array2[j])
                    if (j + 1) < array2.count && array2[j + 1] < array1[i] {
                        m2 = Double(array2[j + 1])
                    } else {
                        m2 = Double(array1[i])
                    }
                }
                result = (m1 + m2) * 0.5
            }
            break
        }
        if !odd { array1[i] < array2[j] ? (i += 1) : (j += 1) }
        f += 1
    }
    return result
}
