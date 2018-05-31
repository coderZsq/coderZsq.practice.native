//
//  CollectionTypeProtocol.swift
//  Advanced
//
//  Created by 朱双泉 on 2018/5/31.
//  Copyright © 2018 Castie!. All rights reserved.
//

import Foundation

struct CollectionTypeProtocol {
    
    static func run() {
        PrefixSequence.run()
        StrideToIterator<Int>.run()
        Fibslterator().run()
        print([1, 2, 3, 4, 2, 1].headMirrorsTail(2))
        ListRun()
        QueueRun()
        IndexRun()
        PrefixIterator2<[Int]>.run()
        QueueRun2()
    }
}

struct ConstantIterator: IteratorProtocol {
    typealias Element = Int
    mutating func next() -> Int? {
        return 1
    }
    
    static func run() {
        var iterator = ConstantIterator()
        while let x = iterator.next() {
            print(x)
        }
    }
}

struct Fibslterator: IteratorProtocol {
    var state = (0, 1)
    mutating func next() -> Int? {
        let upcomingNumber = state.0
        state = (state.1, state.0 + state.1)
        return upcomingNumber
    }
}

struct PrefixIterator: IteratorProtocol {
    let string: String
    var offset: String.Index
    
    init(string: String) {
        self.string = string
        offset = string.startIndex
    }
    
    mutating func next() -> Substring? {
        guard offset < string.endIndex else {return nil}
        offset = string.index(after: offset)
        return string[..<offset]
    }
}

struct PrefixSequence: Sequence {
    let string: String
    func makeIterator() -> PrefixIterator {
        return PrefixIterator(string: string)
    }
    
    static func run() {
        for prefix in PrefixSequence(string: "Hello") {
            print(prefix)
        }
        print(PrefixSequence(string: "Hello").map {$0.uppercased()})
    }
}

extension StrideToIterator {
    
    static func run() {
        let seq = stride(from: 0, to: 10, by: 1)
        var i1 = seq.makeIterator()
        print(i1.next())
        print(i1.next())
        var i2 = i1
        print(i1.next())
        print(i1.next())
        print(i2.next())
        print(i2.next())
        var i3 = AnyIterator(i1)
        var i4 = i3
        print(i3.next())
        print(i4.next())
        print(i3.next())
        print(i3.next())
    }
}

extension Fibslterator {
    
    func fibsIterator() -> AnyIterator<Int> {
        var state = (0, 1)
        return AnyIterator {
            let upcomingNumber = state.0
            state = (state.1, state.0 + state.1)
            return upcomingNumber
        }
    }
    
    func run() {
        let fibsSequence = AnySequence(fibsIterator)
        print(Array(fibsSequence.prefix(10)))
        
        let fibsSequence2 = sequence(state: (0, 1)) {
            (state: inout (Int, Int)) -> Int? in
            let upcomingNumber = state.0
            state = (state.1, state.0 + state.1)
            return upcomingNumber
        }
        print(Array(fibsSequence2.prefix(10)))
    }
}

func standardIn() {
    let standardIn = AnySequence {
        return AnyIterator {
            readLine()
        }
    }
    let numberedStdIn = standardIn.enumerated()
    for (i, line) in numberedStdIn {
        print("\(i + 1) : \(line)")
    }
}

extension Sequence where Element: Equatable, SubSequence: Sequence, SubSequence.Element == Element {
    
    func headMirrorsTail(_ n: Int) -> Bool {
        let head = prefix(n)
        let tail = suffix(n).reversed()
        return head.elementsEqual(tail)
    }
}

enum List<Element> {
    case end
    indirect case node(Element, next: List<Element>)
}

extension List {
    func cons(_ x: Element) -> List {
        return .node(x, next: self)
    }
}

extension List: ExpressibleByArrayLiteral {
    init(arrayLiteral elements: Element...) {
        self = elements.reversed().reduce(.end) {partialList, element in
            partialList.cons(element)
        }
    }
}

extension List {
    mutating func push(_ x: Element) {
        self = self.cons(x)
    }
    
    mutating func pop() -> Element? {
        switch self {
        case .end: return nil
        case let .node(x, next: tail):
            self = tail
            return x
        }
    }
}

extension List: IteratorProtocol, Sequence {
    mutating func next() -> Element? {
        return pop()
    }
}

func ListRun() {
    let emptyList = List<Int>.end
    let oneElementList = List.node(1, next: emptyList)
    print(oneElementList)
    let list = List<Int>.end.cons(1).cons(2).cons(3)
    print(list)
    let list2: List = [3, 2, 1]
    print(list2)
    
    var stack: List<Int> = [3, 2, 1]
    var a = stack
    var b = stack
    
    print(a.pop())
    print(a.pop())
    print(a.pop())
    
    print(stack.pop())
    print(stack.push(4))
    
    print(b.pop())
    print(b.pop())
    print(b.pop())
    
    print(stack.pop())
    print(stack.pop())
    print(stack.pop())
    
    let list3: List = ["1", "2", "3"]
    for x in list3 {
        print("\(x)", terminator: " ")
    }
    print(list3.joined(separator: ", "))
    print(list3.contains("2"))
    print(list3.compactMap {Int($0)})
    print(list3.elementsEqual(["1", "2", "3"]))
}

protocol Queue {
    associatedtype Element
    mutating func enqueue(_ newElement: Element)
    mutating func dequeue() -> Element?
}

struct FIFOQueue<Element>: Queue {
    private var left: [Element] = []
    private var right: [Element] = []

    mutating func enqueue(_ newElement: Element) {
        right.append(newElement)
    }

    mutating func dequeue() -> Element? {
        if left.isEmpty {
            left = right.reversed()
            right.removeAll()
        }
        return left.popLast()
    }
}
/*
extension FIFOQueue: Collection {
    public var startIndex: Int {return 0}
    public var endIndex: Int {return left.count + right.count}
    
    public func index(after i: Int) -> Int {
        precondition(i < endIndex)
        return i + 1
    }
    
    public subscript(position: Int) -> Element {
        precondition((0..<endIndex).contains(position), "Index out of bounds")
        if position < left.endIndex {
            return left[left.count - position - 1]
        } else {
            return right[position - left.count]
        }
    }
    
    typealias Indices = CountableRange<Int>
    var indices: CountableRange<Int> {
        return startIndex..<endIndex
    }
}
*/
extension FIFOQueue: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: Element...) {
        left = elements.reversed()
        right = []
    }
}

func QueueRun() {
    var q = FIFOQueue<String>()
    for x in ["1", "2", "foo", "3"] {
        q.enqueue(x)
    }

    for s in q {
        print(s, terminator: " ")
    }

    var a = Array(q)
    a.append(contentsOf: q[2...3])
    print(a)

    print(q.map {$0.uppercased()})
    print(q.compactMap {Int($0)})
    print(q.filter {$0.count > 1})
    print(q.sorted())
    print(q.joined(separator: " "))

    print(q.isEmpty)
    print(q.count)
    print(q.first)

    let queue: FIFOQueue = [1, 2, 3]
    print(queue)

    let byteQueue: FIFOQueue<UInt8> = [1, 2, 3]
    print(byteQueue)
}

extension Substring {
    var nextWordRange: Range<Index> {
        let start = drop(while: {$0 == " "})
        let end = start.index(where: {$0 == " "}) ?? endIndex
        return start.startIndex..<end
    }
}

struct WordsIndex: Comparable {
    fileprivate let range: Range<Substring.Index>
    fileprivate init(_ value: Range<Substring.Index>) {
        self.range = value
    }
    
    static func <(lhs: Words.Index, rhs: Words.Index) -> Bool {
        return lhs.range.lowerBound < rhs.range.lowerBound
    }
    
    static func ==(lhs: Words.Index, rhs: Words.Index) -> Bool {
        return lhs.range == rhs.range
    }
}

struct Words: Collection {
    let string: Substring
    let startIndex: WordsIndex
    
    init(_ s: String) {
        self.init(s[...])
    }
    
    private init(_ s: Substring) {
        self.string = s
        self.startIndex = WordsIndex(string.nextWordRange)
    }
    
    var endIndex: WordsIndex {
        let e = string.endIndex
        return WordsIndex(e..<e)
    }
}

extension Words {
    subscript(index: WordsIndex) -> Substring {
        return string[index.range]
    }
}

extension Words {
    func index(after i: WordsIndex) -> WordsIndex {
        guard i.range.upperBound < string.endIndex else {
            return endIndex
        }
        let remainder = string[i.range.upperBound...]
        return WordsIndex(remainder.nextWordRange)
    }
}

extension Words {
    subscript(range: Range<WordsIndex>) -> Words {
        let start = range.lowerBound.range.lowerBound
        let end = range.upperBound.range.upperBound
        return Words(string[start..<end])
    }
}

func IndexRun() {
    
    let numbers = [1, 2, 3, 4]
    let squares = numbers.map {$0 * $0}
    let numbersIndex = numbers.index(of: 4)!
    print(squares[numbersIndex])
    
    let hello = "Hello"
    let world = "World"
    let helloIdx = hello.startIndex
    print(world[helloIdx])
    
    var str = "Still I see monsters"
    print(str.split(separator: " "))
    
    print(Array(Words(" hello world test ").prefix(2)))
    
    let words: Words = Words("one two three")
    let onePastStart = words.index(after: words.startIndex)
    let firstDropped = words[onePastStart..<words.endIndex]
    print(Array(firstDropped))
    
    let firstDropped2 = words.suffix(from: onePastStart)
    print(Array(firstDropped2))

    let firstDropped3 = words[onePastStart...]
    print(Array(firstDropped3))
    
    let cites = ["New York", "Rio", "London", "Berlin", "Rome", "Beijing", "Tokyo", "Sydney"]
    let slice = cites[2...4]
    print(cites.startIndex)
    print(cites.endIndex)
    print(slice.startIndex)
    print(slice.endIndex)
}

struct PrefixIterator2<Base: Collection>: IteratorProtocol, Sequence {
    let base: Base
    var offset: Base.Index
    
    init(_ base: Base) {
        self.base = base
        self.offset = base.startIndex
    }
    
    mutating func next() -> Base.SubSequence? {
        guard offset != base.endIndex else {return nil}
        base.formIndex(after: &offset)
        return base.prefix(upTo: offset)
    }
    
    static func run() {
        let numbers = [1, 2, 3]
        print(Array(PrefixIterator2<[Int]>(numbers)))
    }
}

extension BidirectionalCollection {
    public var last: Element? {
        return isEmpty ? nil : self[index(before: endIndex)]
    }
}

extension FIFOQueue: MutableCollection {
    public var startIndex: Int {return 0}
    public var endIndex: Int {return left.count + right.count}

    public func index(after i: Int) -> Int {
        return i + 1
    }

    public subscript(position: Int) -> Element {
        get {
            precondition((0..<endIndex).contains(position), "Index out of bounds")
            if position < left.endIndex {
                return left[left.count - position - 1]
            } else {
                return right[position - left.count]
            }
        }
        set {
            precondition((0..<endIndex).contains(position), "Index out of bounds")
            if position < left.endIndex {
                left[left.count - position - 1] = newValue
            } else {
                return right[position - left.count] = newValue
            }
        }
    }
}

func QueueRun2() {
    var playlist: FIFOQueue = ["Shake It Off", "Blank Space", "Style"]
    print(playlist.first)
    playlist[0] = "You Belong With Me"
    print(playlist.first)
}
