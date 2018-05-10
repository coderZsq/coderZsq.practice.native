//
//  HigherOrderFunc.swift
//  Functional
//
//  Created by 朱双泉 on 2018/5/10.
//  Copyright © 2018 Castie!. All rights reserved.
//

import Foundation

func increment(array: [Int]) -> [Int] {
    var result: [Int] = []
    for x in array {
        result.append(x + 1)
    }
    return result
}

func double(array: [Int]) -> [Int] {
    var result: [Int] = []
    for x in array {
        result.append(x * 2)
    }
    return result
}

func compute(array: [Int], transform:(Int) -> Int) -> [Int] {
    var result: [Int] = []
    for x in array {
        result.append(transform(x))
    }
    return result
}

func double2(array: [Int]) -> [Int] {
    return compute(array: array) {$0 * 2}
}

//Cannot convert value of type 'Bool' to closure result type 'Int'
//func isEven(array: [Int]) -> [Bool] {
//    return compute(array: array) {$0 % 2 == 0}
//}

func compute(array: [Int], transform: (Int) -> Bool) -> [Bool] {
    var result: [Bool] = []
    for x in array {
        result.append(transform(x))
    }
    return result
}

func genericCompute<T>(array: [Int], transform: (Int) -> T) -> [T] {
    var result: [T] = []
    for x in array {
        result.append(transform(x))
    }
    return result
}

func map<Element, T>(_ array: [Element], transform: (Element) -> T) -> [T] {
    var result: [T] = []
    for x in array {
        result.append(transform(x))
    }
    return result
}

func genericCompute2<T>(array: [Int], transform: (Int) -> T) -> [T] {
    return map(array, transform: transform)
}

extension Array {
    func map<T>(_ transform: (Element) -> T) -> [T] {
        var result: [T] = []
        for x in self {
            result.append(transform(x))
        }
        return result
    }
}

func genericCompute3<T>(array: [Int], transform: (Int) -> T) -> [T] {
    return array.map(transform)
}


