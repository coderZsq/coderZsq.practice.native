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
        
        let str: String? = "Never say never"
        
        let upper: String
        if str != nil {
            upper = str!.uppercased()
        } else {
            fatalError("no idea what to do now...")
        }
        
        let result = str?.uppercased()
        print(result)
        
        let lower = str?.uppercased().lowercased()
        print(lower)
        
        print(20.half?.half?.half)
        
        let dictOfArrays = ["nine" : [0, 1, 2, 3]]
        print(dictOfArrays["nine"]?[3])
        
        let dictOfFunctions: [String : (Int, Int) -> Int] = [
            "add": (+),
            "subtract" : (-)
        ]
        print(dictOfFunctions["add"]?(1, 1))
        
        struct Person {
            var name: String
            var age: Int
        }
        
        var optionalLisa: Person? = Person(name: "Lisa Simpson", age: 8)
        if optionalLisa != nil {
            optionalLisa!.age += 1
        }
        print(optionalLisa?.age)
        
        if var lisa = optionalLisa {
            lisa.age += 1
        }
        print(optionalLisa?.age)

        optionalLisa?.age += 1
        print(optionalLisa?.age)
        
        var a: Int? = 5
        a? = 10
        print(a)
        
        var b: Int? = nil
        b? = 10
        print(b)
        
        let stringteger = "1"
        let number1 = Int(stringteger) ?? 0
        
        let array3 = [1, 2, 3]
        print(!array.isEmpty ? array3[0] : 0)
        print(array3.first ?? 0)
        
        print(array3.count > 5 ? array3[5] : 0)
        print(array3[guarded: 5] ?? 0)
        
        let i: Int? = nil
        let j1: Int? = nil
        let k: Int? = 42
        print(i ?? j1 ?? k ?? 0)
        
        let m = i ?? j1 ?? k
        print(type(of: m))
        
        if let n = i ?? j1 {
            print(n)
        }
        
        if let n = i, let m = j1 {}
        
        let s1: String?? = nil
        print((s1 ?? "inner") ?? "outer")
        let s2: String?? = .some(nil)
        print((s2 ?? "inner") ?? "outer")
        
        let bodyTemperature: Double? = 37.0
        let bloodGlucose: Double? = nil
        print(bodyTemperature)
        print("Blood glucose level: \(bloodGlucose)")
        
        print("Body temperature: \(bodyTemperature ??? "n/a")")
        print("Blood glucose level: \(bloodGlucose ??? "n/a")")
        
        let characters: [Character] = ["a", "b", "c"]
        print(String(characters[0]))
        
        var firstCharAsString: String? = nil
        if let char = characters.first {
            firstCharAsString = String(char)
        }
        print(firstCharAsString)
        
        let firstChar = characters.first.map {String($0)}
        print(firstChar)
        
        print([1, 2, 3, 4].reduce(+))
        
        let stringNumbers1 = ["1", "2", "3", "foo"]
        let x = stringNumbers1.first.map {Int($0)}
        print(x)
        let y = stringNumbers1.first.flatMap {Int($0)}
        print(y)
        
        if let a = stringNumbers.first, let b = Int(a) {
            print(b)
        }
        #if false
        let urlString = "https://www.objc.io/logo.png"
        let view = URL(string: urlString)
            .flatMap {try? Data(contentsOf: $0)}
            .flatMap {UIImage(data: $0)}
            .map {UIImageView(image: $0)}
        
        if let view = view {
            
        }
        #endif
        let numbers = ["1", "2", "3", "foo"]
        var sum = 0
        for case let i? in numbers.map({Int($0)}) {
            sum += i
        }
        print(sum)
        
        print(numbers.map {Int($0)}.reduce(0){$0 + ($1 ?? 0)})
        print(numbers.compactMap {Int($0)}.reduce(0, +))
        
        let regex = "^Hello$"
        
        if regex.first == "^" {
            
        }
        
        if regex.first == Optional("^") {
            
        }
        
        var dictWithNils: [String : Int?] = [
            "one" : 1,
            "two" : 2,
            "none" : nil
        ]
        #if false
        dictWithNils["two"] = nil
        print(dictWithNils)
        #endif

        dictWithNils["two"] = Optional(nil)
        dictWithNils["two"] = .some(nil)
        dictWithNils["two"]? = nil
        print(dictWithNils)
        
        dictWithNils["three"]? = nil
        print(dictWithNils.index(forKey: "three"))
    
        let a1: [Int?] = [1, 2, nil]
        let b1: [Int?] = [1, 2, nil]
        a == b
        
        let temps = ["-459.67", "98.6", "warm"]
        let belowFreezing = temps.filter {(Double($0) ?? 0) < 0}
        print(belowFreezing)
        
        let ages = [
            "Tim" : 53, "Angela" : 54, "Craig" : 44,
            "Jony" : 47, "Chris" : 37, "Michael" : 34
        ]
        print(ages.keys
            .filter {name in ages[name]! < 50}
            .sorted())
        
        print(ages.filter {(_, age) in age < 50}
            .map {(name, _) in name}
            .sorted())
        #if false
        let s3 = "foo"
        let i1 = Int(s3) !! "Expecting integer, got \"\(s3)\""

        let s4 = "20"
        let i2 = Int(s4) !? "Expecting integer, got \"\(s4)\""
        
        Int(s) !? (5, "Expected integer")
        
        var output: String? = nil
        output?.write("something") !? "Wasn't expecting chained nil here"
        #endif
        var s5: String! = "Hello"
        print(s5.isEmpty)
        if let s5 = s5 {print(s5)}
        s5 = nil
        print(s ?? "Goodbye")
        
        func increment(x: inout Int) {
            x += 1
        }
        
        var i3 = 1
        increment(x: &i3)
        var j2: Int! = 1
//        increment(x: &j2)
        //Cannot pass immutable value as inout argument: 'j2' is immutable
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

extension Int {
    var half: Int? {
        guard self < -1 || self > 1 else {return nil}
        return self / 2
    }
}

class TextField {
    private (set) var text = ""
    var didChange: ((String) -> ())?
    
    private func textDidChange(newText: String) {
        text = newText
        didChange?(text)
    }
}

extension Array {
    subscript(guarded idx: Int) -> Element? {
        guard (startIndex..<endIndex).contains(idx) else {
            return nil
        }
        return self[idx]
    }
}

infix operator ???

public func ???<T>(optional: T?, defaultValue: @autoclosure () -> String) -> String {
    switch optional {
    case let value?: return String(describing: value)
    case nil: return defaultValue()
    }
}

extension Optional {
    func map<U>(transform: (Wrapped) -> U) -> U? {
        if let value = self {
            return transform(value)
        }
        return nil
    }
}

extension Array {
    
    func reduce(_ nextPartialResult: (Element, Element) -> Element) -> Element? {
        guard let fst = first else {return nil}
        return dropFirst().reduce(fst, nextPartialResult)
    }
    
    func reduce_alt(_ nextPartialResult: (Element, Element) -> Element) -> Element? {
        return first.map {
            dropFirst().reduce($0, nextPartialResult)
        }
    }
}

extension Optional {
    func flatMap<U>(transform: (Wrapped) -> U?) -> U? {
        if let value = self, let transformed = transform(value) {
            return transformed
        }
        return nil
    }
}

func flatten<S: Sequence, T>(source: S) -> [T] where S.Element == T? {
    let filtered = source.lazy.filter {$0 != nil}
    return filtered.map {$0!}
}

extension Sequence {
    func flatMap<U>(transform: (Element) -> U?) -> [U] {
        return flatten(source: self.lazy.map(transform))
    }
}

func ==<T: Equatable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case (nil, nil): return true
    case let (x?, y?): return x == y
    case (_?, nil), (nil, _?): return false
    }
}

func ==<T: Equatable>(lhs: [T?], rhs: [T?]) -> Bool {
    return lhs.elementsEqual(rhs) {$0 == $1}
}

infix operator !!

func !!<T>(wrapped: T?, failureText: @autoclosure () -> String) -> T {
    if let x = wrapped {return x}
    fatalError(failureText())
}

infix operator !?
func !?<T: ExpressibleByIntegerLiteral>(warpped: T?, failureText: @autoclosure () -> String) -> T {
    assert(warpped != nil, failureText())
    return warpped ?? 0
}

func !?<T: ExpressibleByArrayLiteral>(warpped: T?, failureText: @autoclosure () -> String) -> T {
    assert(warpped != nil, failureText())
    return warpped ?? []
}

func !?<T: ExpressibleByStringLiteral>(warpped: T?, failureText: @autoclosure () -> String) -> T {
    assert(warpped != nil, failureText())
    return warpped ?? ""
}

func !?<T>(wrapped: T?, nilDefault: @autoclosure () -> (value: T, text: String)) -> T {
    assert(wrapped != nil, nilDefault().text)
    return wrapped ?? nilDefault().value
}

func !?(wrapped: ()?, failureText: @autoclosure () -> String) {
    assert(wrapped != nil, failureText)
}
