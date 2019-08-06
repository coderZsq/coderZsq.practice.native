//
//  main.swift
//  01-基础语法
//
//  Created by 朱双泉 on 2019/8/6.
//  Copyright © 2019 Castie!. All rights reserved.
//

// MARK: - Hello World

do {
    print("Hello, World!")

    var a = 10
    a = 20
    a = 30

    let b = 20

    print(a)
    print(b)

    print("Hello World - \(a)")
}

// MARK: - 常量
/*
 只能赋值1次
 它的值不要求在编译时期确定, 但使用之前必须赋值1次
 常量, 变量在初始化之前, 都不能使用
 */

do {
    let age: Int
    age = 10
    print(age)
}

do {
    var num = 10
    num += 20
    num += 30
    let age = num
}

do {
    func getAge() -> Int {
        return 10
    }

    let age = getAge()
}

// MARK: - 标识符

do {
    func 🐂🍺() {
        print("666")
    }
    
    let 👽 = "ET"
    var 🥛 = "milk"
    print(👽, 🥛)
}

// MARK: - 常见数据类型

do {
    let letFloat: Float = 30.0
    let letDouble = 30.0
    
    print(UInt8.max)
    print(Int16.min)
}

// MARK: - 字面量

do {
    let bool = true
    let string = "Castiel"
    let character: Character = "🐶"
    
    let intDecimal = 17
    let intBinary = 0b0001
    let intOctal = 0o21
    let intHexadecimal = 0x11

    let doubleDecimal = 125.0
    let doubleHexadecimal1 = 0xFp2
    let doubleHexadecimal2 = 0xFp-2
    
    let array = [1, 3, 5, 7, 9]
    let dictionary = ["age": 18, "height": 168, "weight": 120]
}

// MARK: - 类型转换

do {
    let int1: UInt16 = 2_000
    let int2: UInt8 = 1
    let int3 = int1 + UInt16(int2)
    
    let int = 3
    let double = 0.14159
    let pi = Double(int) + double
    let intPi = Int(pi)
    
    let result = 3 + 0.14159
}

// MARK: - 元组 (Tuple)

do {
    let http404Error = (404, "Not Found")
    print("The status code is \(http404Error.0)")
    
    let (statusCode, statusMessage) = http404Error
    print("The status code is \(statusCode)")
    
    let (justTheStatusCode, _) = http404Error
    
    let http200Status = (statusCode: 200, description: "OK")
    print("The status code is \(http200Status.statusCode)")
}

