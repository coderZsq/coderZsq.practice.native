//
//  main.swift
//  16-泛型
//
//  Created by 朱双泉 on 2019/8/13.
//  Copyright © 2019 Castie!. All rights reserved.
//

// MARK: - 泛型 (Generics)

do {
    func swapValues<T>(_ a: inout T, _ b: inout T) {
        (a, b) = (b, a)
    }
    var i1 = 10
    var i2 = 20
    swapValues(&i1, &i2)
    /*
     0x100001939 <+377>:  movq   0x66f0(%rip), %rdx        ; (void *)0x00007fff838d4d38: type metadata for Swift.Double
     0x100001940 <+384>:  movsd  0x5018(%rip), %xmm0       ; xmm0 = mem[0],zero
     0x100001948 <+392>:  movsd  0x5018(%rip), %xmm1       ; xmm1 = mem[0],zero
     0x100001950 <+400>:  movsd  %xmm1, -0x30(%rbp)
     0x100001955 <+405>:  movsd  %xmm0, -0x38(%rbp)
     0x10000195a <+410>:  leaq   -0x30(%rbp), %rax
     0x10000195e <+414>:  leaq   -0x38(%rbp), %rcx
     0x100001962 <+418>:  movq   %rax, %rdi
     0x100001965 <+421>:  movq   %rcx, %rsi
     0x100001968 <+424>:  callq  0x1000025d0               ; swapValues #1 <T>(inout T, inout T) -> () in _6_泛型 at main.swift:12
     */
    var d1 = 10.0
    var d2 = 20.0
    swapValues(&d1, &d2)
    struct Date {
        var year = 0, month = 0, day = 0
    }
    var dd1 = Date(year: 2011, month: 9, day: 10)
    var dd2 = Date(year: 2012, month: 10, day: 11)
    swapValues(&dd1, &dd2)
}

do {
    func test<T1, T2>(_ t1: T1, _ t2: T2) {}
    var fn: (Int, Double) -> () = test
}

do {
    class Stack<E> {
        var elements = [E]()
        func push(_ element: E) { elements.append(element) }
        func pop() -> E { elements.removeLast() }
        func top() -> E { elements.last! }
        func size() -> Int { elements.count }
    }
    class SubStack<E>: Stack<E> {}
}

do {
    struct Stack<E> {
        var elements = [E]()
        mutating func push(_ element: E) { elements.append(element) }
        mutating func pop() -> E { elements.removeLast() }
        func top() -> E { elements.last! }
        func size() -> Int { elements.count }
    }
    var stack = Stack<Int>()
    stack.push(11)
    stack.push(22)
    stack.push(33)
    print(stack.top())
    print(stack.pop())
    print(stack.pop())
    print(stack.pop())
    print(stack.size())
}

do {
    enum Score<T> {
        case point(T)
        case grade(String)
    }
    let score0 = Score<Int>.point(100)
    let score1 = Score.point(99)
    let score2 = Score.point(99.5)
    let score3 = Score<Int>.grade("A")
}

// MARK: - 关联类型 (Associated Type)

protocol Stackable {
    associatedtype Element
    mutating func push(_ element: Element)
    mutating func pop() -> Element
    func top() -> Element
    func size() -> Int
}

do {
    class Stack<E>: Stackable {
//        typealias Element = E
        var elements = [E]()
        func push(_ element: E) {
            elements.append(element)
        }
        func pop() -> E { elements.removeLast() }
        func top() -> E { elements.last! }
        func size() -> Int { elements.count }
    }
    class StringStack: Stackable {
//        typealias Element = String
        var elements = [String]()
        func push(_ element: String) { elements.append(element) }
        func pop() -> String { elements.removeLast() }
        func top() -> String { elements.last! }
        func size() -> Int { elements.count }
    }
    var ss = StringStack()
    ss.push("Jack")
    ss.push("Rose")
}

// MARK: - 类型约束

protocol Runnable {}

do {
    class Person {}
    func swapValues<T: Person & Runnable>(_ a: inout T, _ b: inout T) {
        (a, b) = (b, a)
    }
}

protocol Stackable2 {
    associatedtype Element: Equatable
}

do {
    class Stack<E: Equatable>: Stackable2 { typealias Element = E }

    func equal<S1: Stackable2, S2: Stackable2>(_ s1: S1, _ s2: S2) -> Bool where S1.Element == S2.Element, S1.Element: Hashable {
        return false
    }
    var stack1 = Stack<Int>()
    var stack2 = Stack<String>()
// Local function 'equal' requires the types 'Int' and 'String' be equivalent
//    equal(stack1, stack2)
}

// MARK: - 协议类型的注意点

do {
    class Person: Runnable {}
    class Car: Runnable {}
    
    func get(_ type: Int) -> Runnable {
        if type == 0 {
            return Person()
        }
        return Car()
    }
    
    var r1 = get(0)
    var r2 = get(1)
}

protocol Runnable2 {
    associatedtype Speed
    var speed: Speed { get }
}

do {
    class Person: Runnable2 {
        var speed: Double { 0.0 }
    }
    class Car: Runnable2 {
        var speed: Int { 0 }
    }
//    Protocol 'Runnable2' can only be used as a generic constraint because it has Self or associated type requirements
//    func get(_ type: Int) -> Runnable2 {
//        if type == 0 {
//            return Person()
//        }
//        return Car()
//    }
}

// MARK: - 泛型解决

do {
    class Person: Runnable2 {
        var speed: Double { 0.0 }
    }
    class Car: Runnable2 {
        var speed: Int { 0 }
    }
    func get<T: Runnable2>(_ type: Int) -> T {
        if type == 0 {
            return Person() as! T
        }
        return Car() as! T
    }
    var r1: Person = get(0)
    var r2: Car = get(1)
}

// 不透明类型 (Opaque Type)

do {
    class Person: Runnable2 {
        var speed: Double { 0.0 }
    }
    class Car: Runnable2 {
        var speed: Int { 0 }
    }
    func get(_ type: Int) -> some Runnable2 { Car() }
    var r1 = get(0)
    var r2 = get(1)
}

// MARK: - some

protocol Runnable3 {
    associatedtype Speed
}

do {
    class Dog: Runnable3 { typealias Speed = Double }
    class Person {
        var pet: some Runnable3 {
            return Dog()
        }
    }
}

// MARK: - 可选项的本质

do {
//    enum Optional<Wrapped>: ExpressibleByNilLiteral {
//        case none
//        case some(Wrapped)
//        public init(_ some: Wrapped)
//    }
    var age: Int? = 10
    var age0: Optional<Int> = Optional<Int>.some(10)
    var age1: Optional = .some(10)
    var age2 = Optional.some(10)
    var age3 = Optional(10)
    age = nil
    age3 = .none
}

do {
    var age: Int? = nil
    var age0 = Optional<Int>.none
    var age1: Optional<Int> = .none
}

do {
    var age: Int? = .none
    age = 10
    age = .some(20)
    age = nil
    
    switch age {
    case let v?:
        print("some", v)
    case nil:
        print("none")
    }
    
    switch age {
    case let .some(v):
        print("some", v)
    case nil:
        print("none")
    }
}

do {
    var age_: Int? = 10
    var age: Int?? = age_
    age = nil
    
    var age0 = Optional.some(Optional.some(10))
    age0 = .none
    var age1: Optional<Optional> = .some(.some(10))
    age1 = .none
}

do {
    var age: Int?? = 10
    var age0: Optional<Optional> = 10
}
