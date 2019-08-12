//
//  main.swift
//  13-可选链
//
//  Created by 朱双泉 on 2019/8/12.
//  Copyright © 2019 Castie!. All rights reserved.
//

// MARK: - 可选链 (Optional Chaining)
/*
 如果可选项为nil, 调用方法, 下标, 属性失败, 结果为nil
 如果可选项不为nil, 调用方法, 下标, 属性成功, 结果会被包装成可选项
 如果结果本来就是可选项, 不会进行再次包装
 */

do {
    class Car { var price = 0 }
    class Dog { var weight = 0 }
    class Person {
        var name: String = ""
        var dog: Dog = Dog()
        var car: Car? = Car()
        func age() -> Int { 18 }
        func eat() { print("Person eat") }
        subscript(index: Int) -> Int { index }
    }
    var person: Person? = Person()
    var age1 = person!.age()
    var age2 = person?.age()
    var name = person?.name
    var index = person?[6]
    func getName() -> String { "jack" }
    person?.name = getName()
    if let _ = person?.eat() {
        print("eat调用成功")
    } else {
        print("eat调用失败")
    }
    var dog = person?.dog
    var weight = person?.dog.weight
    var price = person?.car?.price
}

do {
    var scores = ["Jack": [86, 82, 84], "Rose": [79, 94, 81]]
    scores["Jack"]?[0] = 100
    scores["Rose"]?[2] += 10
    scores["Kate"]?[0] = 88
    
    var num1: Int? = 5
    num1? = 10
    
    var num2: Int? = nil
    num2? = 10
    
    var dict: [String: (Int, Int) -> Int] = [
        "sum": (+),
        "difference": (-)
    ]
    var result = dict["sum"]?(10, 20)
}
