//
//  OptionalValue.swift
//  Advanced
//
//  Created by 朱双泉 on 2018/6/1.
//  Copyright © 2018 Castie!. All rights reserved.
//

import UIKit

struct OptionalValue {
    
    static func run() {
        var array = ["one", "two", "three"]
//        let idx = array.index(of: "four")
//        Value of optional type 'Int?' not unwrapped; did you mean to use '!' or '?'?
//        array.remove(at: idx)
        switch array.index(of: "four") {
        case .some(let idx):
            array.remove(at: idx)
        case .none:
            break
        }
        switch array.index(of: "four") {
        case let idx?:
            array.remove(at: idx)
        case nil:
            break
        }
    
//        if let idx = array.index(of: "four") {
//            array.remove(at: idx)
//        }
        
        if let idx = array.index(of: "four"), idx != array.startIndex {
            array.remove(at: idx)
        }
        #if false
        let urlString = "https://www.objc.io/logo.png"
        if let url = URL(string: urlString),
           let data = try? Data(contentsOf: url),
           let image = UIImage(data: data)
        {
            let view = UIImageView(image: image)
        }
        
        if let url = URL(string: urlString), url.pathExtension == "png",
           let data = try? Data(contentsOf: url),
           let image = UIImage(data: data)
        {
            let view = UIImageView(image: image)
        }

        let scanner = Scanner(string: "lisa123")
        var username: NSString?
        let alphas = CharacterSet.alphanumerics

        if scanner.scanCharacters(from: alphas, into: &username),
            let name = username {
            print(name)
        }

        while let line = readLine() {
            print(line)
        }

        while let line = readLine(), !line.isEmpty {
            print(line)
        }
        #endif
        let array1 = [1, 2, 3]
        var iterator = array1.makeIterator()
        while let i = iterator.next() {
            print(i, terminator: " ")
        }
        
        for i in 0..<10 where i % 2 == 0 {
            print(i, terminator: " ")
        }
        
        var iterator1 = (0..<10).makeIterator()
        while let i = iterator1.next() {
            if i % 2 == 0 {
                print(i)
            }
        }
        
        var functions: [() -> Int] = []
        for i in 1...3 {
            functions.append {i}
        }
        for f in functions {
            print("\(f())", terminator: " ")
        }
        
        var functions1: [() -> Int] = []
        var iterator2 = (1...3).makeIterator()
        var current1: Int? = iterator2.next()
        while current1 != nil {
            let i = current1!
            functions1.append {i}
            current1 = iterator2.next()
        }
        
        let stringNumbers = ["1", "2", "three"]
        let maybeInts = stringNumbers.map {Int($0)}
        print(maybeInts)
        
        var iterator3 = maybeInts.makeIterator()
        while let maybeInt = iterator3.next() {
            print(maybeInt, terminator: " ")
        }
        
        for case let i? in maybeInts {
            print(i, terminator: " ")
        }
        
        for case nil in maybeInts {
            print("No value")
        }
        
        for case let .some(i) in maybeInts {
            print(i)
        }
        
        let j = 5
        if case 0..<10 = j {
            print("\(j)在范围内")
        }
        
        let s = "Taylor Swift"
        if case Pattern("Swift") = s {
            print("\(String(reflecting: s)) contains \"Swift\"")
        }
        
        let number = "1"
        if var i = Int(number) {
            i += 1
            print(i)
        }
        
        let array2 = [1, 2, 3]
        if !array2.isEmpty {
            print(array2[0])
        }
        
        if let firstElement = array.first {
            print(firstElement)
        }
        
        func doStuff(withArray a: [Int]) {
            if a.isEmpty {
                return
            }
            a[0]
        }

        print("hello.txt".fileExtension)
        
        func doStuff1(withArray a: [Int]) {
            guard let firstElement = a.first else {
                return
            }
            firstElement
        }
        
        func doStuff2(withArray a: [Int]) {
            guard !a.isEmpty else {return}
            a.first
            a[0]
        }
    }
}

struct Pattern {
    let s: String
    init(_ s: String) {self.s = s}
}

func ~=(pattern: Pattern, value: String) -> Bool {
    return value.range(of: pattern.s) != nil
}

func ~=<T, U>(_ : T, _ : U) -> Bool {return true}

extension String {
    var fileExtension: String? {
        let period: String.Index
        if let idx = index(of: ".") {
            period = idx
        } else {
            return nil
        }
        let extensionStart = index(after: period)
        return String(self[extensionStart...])
    }
    
    var fileExtension1: String? {
        guard let period = index(of: ".") else {
            return nil
        }
        let extensionStart = index(after: period)
        return String(self[extensionStart...])
    }
}

func unimplemented() -> Never {
    fatalError("This code path is not implemented yet.")
}
