//
//  main.swift
//  DataStructure
//
//  Created by 朱双泉 on 05/01/2018.
//  Copyright © 2018 Castie!. All rights reserved.
//

import Foundation

public func scope(of description: String, execute: Bool, action: () -> ()) {
    guard execute else { return }
    print("--- scope of:", description, "---")
    action()
}

scope(of: "queue", execute: false) {
    
    let intQ = Queue<Int>()
    intQ.entry(1)
    intQ.entry(2)
    intQ.entry(3)
    intQ.traverse()
    
    print(intQ.depart()!)
    intQ.traverse()
    
    print(intQ.depart()!)
    intQ.traverse()
    
    intQ.entry(4)
    intQ.entry(5)
    intQ.traverse()
    
    print(intQ.depart()!)
    intQ.traverse()
    
    let stringQ = Queue<String>(5)
    stringQ.entry("one")
    stringQ.entry("two")
    stringQ.entry("three")
    stringQ.entry("four")
    stringQ.entry("five")
    stringQ.entry("six")
    stringQ.entry("seven")
    stringQ.entry("eight")
    stringQ.entry("nine")
    stringQ.traverse()
    
    print(stringQ.depart()!)
    print(stringQ.depart()!)
    print(stringQ.depart()!)
    stringQ.entry("ten")
    stringQ.traverse()
}

scope(of: "stack", execute: true) {
    
    let intS = Stack<Int>(3)
    intS.push(1)
    intS.push(2)
    intS.push(3)
    intS.push(4)
    intS.traverse()

    print(intS.pop()!)
    intS.traverse()

    intS.push(5)
    intS.push(6)
    intS.traverse()

    print(intS.pop()!)
    intS.traverse()

    let stringS = Stack<String>()
    stringS.push("one")
    stringS.push("two")
    stringS.push("three")
    stringS.traverse()

    stringS.pop()
    stringS.pop()
    stringS.pop()
    stringS.pop()
    stringS.traverse()

    func converse(_ origin: Int , format: Int) -> String {
        let stack = Stack<Int>(30)
        var ori = origin
        var mod = 0
        var char = ["0","1","2","3","4","5","6","7","8","9",
                    "A","B","C","D","E","F"]
        var conversed = ""
        while ori != 0 {
            mod = ori % format
            stack.push(mod)
            ori /= format
        }
        while !stack.isEmpty() {
            guard let index = stack.pop() else { continue }
            conversed += char[index]
        }
        stack.clear()
        return "(\(conversed))"
    }
    print(converse(1000, format: 2))
    print(converse(1000, format: 8))
    print(converse(1000, format: 10))
    print(converse(123456789, format: 16))

    func match(_ brackets: String) -> Bool {
        let stack = Stack<Character>(30)
        let needStack = Stack<Character>(30)
        var currentNeed = Character(" ")
        for i in 0..<brackets.count {
            let char = brackets[brackets.index(brackets.startIndex, offsetBy: i)]
            if  char != currentNeed {
                stack.push(char)
                switch char {
                case "[":
                    if currentNeed != Character(" ") {
                        needStack.push(currentNeed)
                    }
                    currentNeed = "]"
                    break
                case "(":
                    if currentNeed != Character(" ") {
                        needStack.push(currentNeed)
                    }
                    currentNeed = ")"
                    break
                default:
                    return false
                }
            } else {
                stack.pop()
                guard let need = needStack.pop() else { currentNeed = Character(" "); continue }
                currentNeed = need
            }
        }
        return stack.isEmpty()
    }
    print(match("[]()[]()[]") ? "match" : "not match")
}
