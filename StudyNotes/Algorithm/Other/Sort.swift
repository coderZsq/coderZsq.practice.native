//
//  Sort.swift
//  Algorithm
//
//  Created by 朱双泉 on 26/02/2018.
//  Copyright © 2018 Castie!. All rights reserved.
//

import Foundation

func selectSort(list: inout [Int]) {
    
    let n = list.count
    for i in 0..<(n-1) {
        var j = i + 1
        for _ in j..<n {
            if list[i] > list[j] {
                list[i] ^= list[j]
                list[j] ^= list[i]
                list[i] ^= list[j]
            }
            j += 1
        }
    }
}

func optimizationSelectSort(list: inout [Int]) {
    
    let n = list.count
    var idx = 0
    for i in 0..<(n - 1) {
        idx = i;
        var j = i + 1
        for _ in j..<n {
            if list[idx] > list[j] {
                idx = j;
            }
            j += 1
        }
        if idx != i {
            list[i] ^= list[idx]
            list[idx] ^= list[i]
            list[i] ^= list[idx]
        }
    }
}

func popSort(list: inout [Int]) {

    let n = list.count
    for i in 0..<n-1 {
        var j = 0
        for _ in 0..<(n-1-i) {
            if list[j] > list[j+1] {
                list[j] ^= list[j+1]
                list[j+1] ^= list[j]
                list[j] ^= list[j+1]
            }
            j += 1
        }
    }
}

func optimizationPopSort(list: inout [Int]) {

    let n = list.count
    for i in 0..<n-1 {
        var flag = 0
        var j = 0
        for _ in 0..<(n-1-i) {
            if list[j] > list[j+1] {
                list[j] ^= list[j+1]
                list[j+1] ^= list[j]
                list[j] ^= list[j+1]
                flag = 1
            }
            j += 1
        }
        if flag == 0 {
            break
        }
    }
}

func quickSort(list: inout [Int]) {

    func sort(list: inout [Int], low: Int, high: Int) {
        if low < high {
            let pivot = list[low]
            var l = low; var h = high
            while l < h {
                while list[h] >= pivot && l < h {h -= 1}
                list[l] = list[h]
                while list[l] <= pivot && l < h {l += 1}
                list[h] = list[l]
            }
            list[h] = pivot
            print(list)
            sort(list: &list, low: low, high: l-1)
            sort(list: &list, low: l+1, high: high)
        }
    }
    sort(list: &list, low: 0, high: list.count - 1)
}



