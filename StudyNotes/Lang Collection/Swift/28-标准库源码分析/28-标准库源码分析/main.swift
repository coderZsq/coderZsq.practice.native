//
//  main.swift
//  28-标准库源码分析
//
//  Created by 朱双泉 on 2019/8/27.
//  Copyright © 2019 Castie!. All rights reserved.
//

// MARK: - Array分析

#if false
@inlinable
public func map<T>(
    _ transform: (Element) throws -> T
) rethrows -> [T] {
    let initialCapacity = underestimatedCount
    var result = ContiguousArray<T>()
    result.reserveCapacity(initialCapacity)
    
    var iterator = self.makeIterator()
    
    // Add elements up to the initial capacity without checking for regrowth.
    for _ in 0..<initialCapacity {
        result.append(try transform(iterator.next()!))
    }
    // Add remaining elements, if any.
    while let element = iterator.next() {
        result.append(try transform(element))
    }
    return Array(result)
}
#endif

#if false
@inlinable
public __consuming func filter(
    _ isIncluded: (Element) throws -> Bool
) rethrows -> [Element] {
    return try _filter(isIncluded)
}

@_transparent
public func _filter(
    _ isIncluded: (Element) throws -> Bool
) rethrows -> [Element] {
    
    var result = ContiguousArray<Element>()
    
    var iterator = self.makeIterator()
    
    while let element = iterator.next() {
        if try isIncluded(element) {
            result.append(element)
        }
    }
    
    return Array(result)
}
#endif

#if false
@inlinable
public func flatMap<SegmentOfResult: Sequence>(
    _ transform: (Element) throws -> SegmentOfResult
) rethrows -> [SegmentOfResult.Element] {
    var result: [SegmentOfResult.Element] = []
    for element in self {
        result.append(contentsOf: try transform(element))
    }
    return result
}
#endif

#if false
@inlinable
public func reduce<Result>(
    _ initialResult: Result,
    _ nextPartialResult:
    (_ partialResult: Result, Element) throws -> Result
) rethrows -> Result {
    var accumulator = initialResult
    for element in self {
        accumulator = try nextPartialResult(accumulator, element)
    }
    return accumulator
}
#endif

#if false
@inlinable // protocol-only
public func compactMap<ElementOfResult>(
    _ transform: (Element) throws -> ElementOfResult?
) rethrows -> [ElementOfResult] {
    return try _compactMap(transform)
}

@inlinable // protocol-only
@inline(__always)
public func _compactMap<ElementOfResult>(
    _ transform: (Element) throws -> ElementOfResult?
) rethrows -> [ElementOfResult] {
    var result: [ElementOfResult] = []
    for element in self {
        if let newElement = try transform(element) {
            result.append(newElement)
        }
    }
    return result
}
#endif

// MARK: - Substring分析

#if false
extension Substring {
    @_alwaysEmitIntoClient
    public var base: String { return _slice.base }
}

@frozen
public struct Substring {
    @usableFromInline
    internal var _slice: Slice<String>
    
    @inlinable
    internal init(_ slice: Slice<String>) {
        let _guts = slice.base._guts
        let start = _guts.scalarAlign(slice.startIndex)
        let end = _guts.scalarAlign(slice.endIndex)
        
        self._slice = Slice(
            base: slice.base,
            bounds: Range(uncheckedBounds: (start, end)))
        _invariantCheck()
    }
    
    @inline(__always)
    internal init(_ slice: _StringGutsSlice) {
        self.init(String(slice._guts)[slice.range])
    }
    
    /// Creates an empty substring.
    @inlinable @inline(__always)
    public init() {
        self.init(Slice())
    }
}

@inlinable // specialize
public mutating func append<S: Sequence>(contentsOf elements: S)
    where S.Element == Character {
        var string = String(self)
        self = Substring() // Keep unique storage if possible
        string.append(contentsOf: elements)
        self = Substring(string)
}

extension Substring {
    public func lowercased() -> String {
        return String(self).lowercased()
    }
    
    public func uppercased() -> String {
        return String(self).uppercased()
    }
}
#endif

// MARK: - Optional分析

#if false
@inlinable
public func map<U>(
    _ transform: (Wrapped) throws -> U
) rethrows -> U? {
    switch self {
    case .some(let y):
        return .some(try transform(y))
    case .none:
        return .none
    }
}

@inlinable
public func flatMap<U>(
    _ transform: (Wrapped) throws -> U?
) rethrows -> U? {
    switch self {
    case .some(let y):
        return try transform(y)
    case .none:
        return .none
    }
}

@frozen
public struct _OptionalNilComparisonType: ExpressibleByNilLiteral {
    /// Create an instance initialized with `nil`.
    @_transparent
    public init(nilLiteral: ()) {
    }
}
#endif

extension Optional where Wrapped: Equatable {
    @inlinable
    public static func ==(lhs: Wrapped?, rhs: Wrapped?) -> Bool {
        print(lhs, rhs)
        switch (lhs, rhs) {
        case let (l?, r?):
            print(l, r)
            return l == r
        case (nil, nil):
            return true
        default:
            return false
        }
    }
    
    @_transparent
    public static func ==(lhs: Wrapped?, rhs: _OptionalNilComparisonType) -> Bool {
        switch lhs {
        case .some:
            return false
        case .none:
            return true
        }
    }
    
    @_transparent
    public static func ==(lhs: _OptionalNilComparisonType, rhs: Wrapped?) -> Bool {
        switch rhs {
        case .some:
            return false
        case .none:
            return true
        }
    }
}

do {
    var age1: Int???? = 10
    var age2: Int = 10
    print(nil == age1)
    print(age1 == nil)
    print(age1 == age2)
}

@_transparent
public func ?? <T>(optional: T?, defaultValue: @autoclosure () throws -> T)
    rethrows -> T {
        print(optional)
  switch optional {
  case .some(let value):
    return value
  case .none:
    return try defaultValue()
  }
}

@_transparent
public func ?? <T>(optional: T?, defaultValue: @autoclosure () throws -> T?)
    rethrows -> T? {
  switch optional {
  case .some(let value):
    return value
  case .none:
    return try defaultValue()
  }
}

do {
    var age1: Int???? = nil
    var age2: Int? = 20
    print(age1 ?? age2)
}

// MARK: - 反射
/*
 反射是编程语言中一项强大的能力, 比如Java的反射机制
 对于任意一个类型, 都能够动态获取这个类的所有属性和方法信息
 对于任意一个实例, 都能够动态调用它的任意方法和属性
 
 Swift的反射机制目前还比较弱, 通过Mirror类型来提供简单的反射功能
 */

do {
    struct Person {
        var age: Int = 0
        var name: String = ""
    }
    
    let mirror = Mirror(reflecting: Person(age: 10, name: "Jack"))
    print(mirror.displayStyle!)
    print(mirror.subjectType)
    print(mirror.superclassMirror as Any)
    for case let (label?, value) in mirror.children {
        print(label, value)
    }
}
