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

let exampleFiles = ["README.md", "HelloWorld.swift", "FlappyBird.swift"]

func getSwiftFiles(in files: [String]) -> [String] {
    var result: [String] = []
    for file in files {
        if file.hasSuffix(".swift") {
            result.append(file)
        }
    }
    return result
}

//getSwiftFiles(in: exampleFiles)

extension Array {
    func filter(_ includeElement: (Element) -> Bool) -> [Element] {
        var result: [Element] = []
        for x in self where includeElement(x) {
            result.append(x)
        }
        return result
    }
}

func getSwiftFile2(in files: [String]) -> [String] {
    return files.filter{file in file.hasSuffix(".swift")}
}

func sum(integers: [Int]) -> Int {
    var result: Int = 0
    for x in integers {
        result += x
    }
    return result
}

//sum(integers: [1, 2, 3, 4])

func product(integers: [Int]) -> Int {
    var result: Int = 1
    for x in integers {
        result = x * result
    }
    return result
}

func concatenate(strings: [String]) -> String {
    var result: String = ""
    for string in strings {
        result += string
    }
    return result
}

func prettyPrint(strings: [String]) -> String {
    var result: String = "Entire in the array xs: \n"
    for string in strings {
        result = " " + result + string + "\n"
    }
    return result
}

extension Array {
    func reduce<T>(_ initial: T, combine: (T, Element) -> T) -> T {
        var result = initial
        for x in self {
            result = combine(result, x)
        }
        return result
    }
}

func sumUsingReduce(integers: [Int]) -> Int {
    return integers.reduce(0) {result, x in result + x}
}

func productUsingReduce(integers: [Int]) -> Int {
    return integers.reduce(1, combine: *)
}

func concatUsingReduce(strings: [String]) -> String {
    return strings.reduce("", combine: +)
}

func flatten<T>(_ xss: [[T]]) -> [T] {
    var result: [T] = []
    for xs in xss {
        result += xs
    }
    return result
}

func flattenUsingReduce<T>(_ xss: [[T]]) -> [T] {
    return xss.reduce([]){result, xs in result + xs}
}

extension Array {
    func mapUsingReduce<T>(_ transform: (Element) -> T) -> [T] {
        return reduce([]) { result, x in
            return result + [transform(x)]
        }
    }
    
    func filterUsingReduce(_ includeElement: (Element) -> Bool) -> [Element] {
        return reduce([]) { result, x in
            return includeElement(x) ? result + [x] : result
        }
    }
}
#if false
infix operator >>>
func >>><A, B, C>(f: @escaping (A) -> B, g: @escaping (B) -> C) -> (A) -> C {
    return {x in g(f(x))}
}

func curry<A, B, C>(_ f: @escaping (A, B) -> C) -> (A) -> (B) -> C {
    return { x in { y in f(x, y) } }
}
#endif
