//
//  main.swift
//  05-可选项
//
//  Created by 朱双泉 on 2019/8/7.
//  Copyright © 2019 Castie!. All rights reserved.
//

// MARK: - 可选项 (Optional)

do {
    var name: String? = "Jack"
    name = nil
    
    var age: Int?
    age = 10
    age = nil
    
    var array = [1, 15, 40, 29]
    func get(_ index: Int) -> Int? {
        if index < 0 || index >= array.count {
            return nil
        }
        return array[index]
    }
    
    print(get(1))
    print(get(-1))
    print(get(4))
}

// MARK: - 强制解包 (Forced Unwrapping)

do {
    var age: Int?
    age = 10
    age = nil
}

do {
    var age: Int? = 10
    var ageInt: Int = age!
    ageInt += 10
}

do {
    // 如果对值为nil的(空盒子)进行强制解包,将会产生错误
//    var age: Int?
//    age!
}

// MARK: - 判断可选项是否包含值
 
do {
    let number = Int("123")
    if number != nil {
        print("字符串转换整数成功: \(number!)")
    } else {
        print("字符串转换整数失败")
    }
}

// MARK: - 可选项绑定 (Optional Binding)
// 如果包含就自动解包, 把值赋给一个临时的常量(let)或者变量(var), 并返回true, 否则返回false

do {
    if let number = Int("123") {
        print("字符串转换整数成功: \(number)")
    } else {
        print("字符串转换整数失败")
    }
}

do {
    enum Season: Int {
        case spring = 1, summer, autumn, winter
    }
    if let season = Season(rawValue: 6) {
        switch season {
        case .spring:
            print("the season is spring")
        default:
            print("the season is other")
        }
    } else {
        print("no such season")
    }
}

// MARK: - 等价写法

do {
    if let first = Int("4") {
        if let second = Int("42") {
            if first < second && second < 100 {
                print("\(first) < \(second) < 100")
            }
        }
    }
    
    if let first = Int("4"),
        let second = Int("42"),
        first < second && second < 100 {
        print("\(first) < \(second) < 100")
    }
}

// MARK: - while循环中使用可选项绑定

do {
    var strs = ["10", "20", "abc", "-20", "30"]
    var index = 0
    var sum = 0
    while let num = Int(strs[index]), num > 0 {
        sum += num
        index += 1
    }
    print(sum)
}

// MARK: - 空合并运算符?? (Nil-Coalescing Operator)

do {
    let a: Int? = 1
    let b: Int? = 2
    let c = a ?? b
}

do {
    let a: Int? = nil
    let b: Int? = 2
    let c = a ?? b
}

do {
    let a: Int? = nil
    let b: Int? = nil
    let c = a ?? b
}

do {
    let a: Int? = 1
    let b: Int = 2
    let c = a ?? b
}

do {
    let a: Int? = nil
    let b: Int = 2
    let c = a ?? b
}

do {
    let a: Int? = nil
    let b: Int = 2
    
    let c: Int
    if let tmp = a {
        c = tmp
    } else {
        c = b
    }
}

// MARK: - 多个??一起使用

do {
    let a: Int? = 1
    let b: Int? = 2
    let c = a ?? b ?? 3
}

do {
    let a: Int? = nil
    let b: Int? = 2
    let c = a ?? b ?? 3
}

do {
    let a: Int? = nil
    let b: Int? = nil
    let c = a ?? b ?? 3
}

// MARK: - ??和if let配合使用

do {
    let a: Int? = nil
    let b: Int? = 2
    if let c = a ?? b {
        print(c)
    }
    
    if let c = a, let d = b {
        print(c)
        print(d)
    }
}

// MARK: - if语句实现登录

do {
    func login(_ info: [String: String]) {
        let username: String
        if let tmp = info["username"] {
            username = tmp
        } else {
            print("请输入用户名")
            return
        }
        let password: String
        if let tmp = info["password"] {
            password = tmp
        } else {
            print("请输入密码")
            return
        }
        print("用户名: \(username)", "密码: \(password)", "登录ing")
    }
    
    login(["username": "jack", "password": "123456"])
    login(["password": "123456"])
    login(["username": "jack"])
}

// MARK: - guard语句

do {
    func login(_ info: [String: String]) {
        guard let username = info["username"] else {
            print("请输入用户名")
            return
        }
        guard let password = info["password"] else {
            print("请输入密码")
            return
        }
        print("用户名: \(username)", "密码: \(password)", "登录ing")
    }
}

// MARK: - 隐式解包 (Implicitly Unwrapped Optional)

do {
    let num1: Int! = 10
    let num2: Int = num1
    if num1 != nil {
        print(num1 + 6)
    }
    if let num3 = num1 {
        print(num3)
    }
}

do {
    let num1: Int! = nil
//    let num2: Int = num1
}

// MARK: - 字符串插值

do {
    var age: Int? = 10
    print("My age is \(age)")
    
    print("My age is \(age!)")
    print("My age is \(String(describing: age))")
    print("My age is \(age ?? 0)")
}

// MARK: - 多重可选项
// 可以使用lldb指令 frame variable -R 或者 fr v -R 查看区别

do {
    /*
     (lldb) fr v -R num1
     (Swift.Optional<Swift.Int>) num1 = some {
       some = {
         _value = 10
       }
     }
     (lldb) fr v -R num2
     (Swift.Optional<Swift.Optional<Swift.Int>>) num2 = some {
       some = some {
         some = {
           _value = 10
         }
       }
     }
     (lldb) fr v -R num3
     (Swift.Optional<Swift.Optional<Swift.Int>>) num3 = some {
       some = some {
         some = {
           _value = 10
         }
       }
     }
     */
    var num1: Int? = 10
    var num2: Int?? = num1
    var num3: Int?? = 10
    print(num2 == num3)
}

do {
    /*
     (lldb) fr v -R num1
     (Swift.Optional<Swift.Int>) num1 = none {
       some = {
         _value = 0
       }
     }
     (lldb) fr v -R num2
     (Swift.Optional<Swift.Optional<Swift.Int>>) num2 = some {
       some = none {
         some = {
           _value = 0
         }
       }
     }
     (lldb) fr v -R num3
     (Swift.Optional<Swift.Optional<Swift.Int>>) num3 = none {
       some = some {
         some = {
           _value = 0
         }
       }
     }
     */
    var num1: Int? = nil
    var num2: Int?? = num1
    var num3: Int?? = nil
    print(num2 == num3)
    print((num2 ?? 1) ?? 2)
    print((num3 ?? 1) ?? 2)
}
