//
//  main.swift
//  25-函数式编程
//
//  Created by 朱双泉 on 2019/8/21.
//  Copyright © 2019 Castie!. All rights reserved.
//

// MARK: - Array的常见操作

do {
    var arr = [1, 2, 3, 4]
    var arr2 = arr.map { $0 * 2 }
    var arr3 = arr.filter { $0 % 2 == 0 }
    var arr4 = arr.reduce(0) { $0 + $1 }
    var arr5 = arr.reduce(0, +)
}

do {
    func double(_ i: Int) -> Int { i * 2 }
    var arr = [1, 2, 3, 4]
    print(arr.map(double))
}

do {
    var arr = [1, 2, 3]
    var arr2 = arr.map { Array.init(repeating: $0, count: $0) }
    var arr3 = arr.flatMap { Array.init(repeating: $0, count: $0) }
}

do {
    var arr = ["123", "test", "jack", "-30"]
    var arr2 = arr.map { Int($0) }
    var arr3 = arr.compactMap { Int($0) }
}

do {
    var arr = [1, 2, 3, 4]
    print(arr.map { $0 * 2 })
    print(arr.reduce([]) { $0 + [$1 * 2]})
    
    print(arr.filter { $0 % 2 == 0 })
    print(arr.reduce([]) { $1 % 2 == 0 ? $0 + [$1] : $0 })
}

// MARK: - lazy的优化

do {
    let arr = [1, 2, 3]
    let result = arr.lazy.map {
        (i: Int) -> Int in
        print("mapping \(i)")
        return i * 2
    }
    print("begin-----")
    print("mapped", result[0])
    print("mapped", result[1])
    print("mapped", result[2])
    print("end----")
}

// MARK: - Optional的map和flatMap

do {
    var num1: Int? = 10
    var num2 = num1.map { $0 * 2 }
    var num3: Int? = nil
    var num4 = num3.map { $0 * 2 }
}

do {
    var num1: Int? = 10
    var num2 = num1.map { Optional.some($0 * 2) }
    var num3 = num1.flatMap { Optional.some($0 * 2) }
}

do {
    var num1: Int? = 10
    var num2 = (num1 != nil) ? (num1! + 10) : nil
    var num3 = num1.map { $0 + 10 }
}

import Foundation
do {
    var fmt = DateFormatter()
    fmt.dateFormat = "yyyy-MM-dd"
    var str: String? = "2011-09-10"
    var date1 = str != nil ? fmt.date(from: str!) : nil
    var date2 = str.flatMap(fmt.date)
}

do {
    var score: Int? = 98
    var str1 = score != nil ? "score is \(score!)" : "No score"
    var str2 = score.map { "score is \($0)" } ?? "No score"
}

do {
    struct Person {
        var name: String
        var age: Int
    }
    var items = [
        Person(name: "jack", age: 20),
        Person(name: "rose", age: 21),
        Person(name: "kate", age: 22)
    ]
    func getPerson1(_ name: String) -> Person? {
        let index = items.firstIndex { $0.name == name }
        return index != nil ? items[index!] : nil
    }
    func getPerson2(_ name: String) -> Person? {
        return items.firstIndex { $0.name == name }.map { items[$0] }
    }
}

do {
    struct Person {
        var name: String
        var age: Int
        init?(_ json: [String: Any]) {
            guard let name = json["name"] as? String,
            let age = json["age"] as? Int  else {
                return nil
            }
            self.name = name
            self.age = age
        }
    }
    var json: Dictionary? = ["name": "jack", "age": 10]
    var p1 = json != nil ? Person(json!) : nil
    var p2 = json.flatMap(Person.init)
}
