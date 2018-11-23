//
//  ParserCombinator.swift
//  Functional
//
//  Created by 朱双泉 on 2018/5/22.
//  Copyright © 2018 Castie!. All rights reserved.
//

import Foundation

#if false
typealias Parser<Result> = (String) -> (Result, String)?
#endif

#if false
typealias Stream = String.CharacterView
typealias Parser<Result> = (Stream) -> (Result, Stream)?
#endif

struct Parser<Result> {
    typealias Stream = String.CharacterView
    let parse: (Stream) -> (Result, Stream)?
}

func character(matching condition: @escaping (Character) -> Bool) -> Parser<Character> {
    return Parser(parse: { input in
        guard let char = input.first, condition(char) else { return nil }
        return (char, input.dropFirst())
    })
}

class ParserCombinator {
    static func run() {
        let one = character { $0 == "1" }
        print(one.parse("123".characters))
    }
}

extension Parser {
    func run(_ string: String) -> (Result, String)? {
        guard let (result, reminder) = parse(string.characters) else { return nil }
        return (result, String(reminder))
    }
}

extension ParserCombinator {
    static func run2() {
        let one = character { $0 == "1" }
        print(one.run("123"))
    }
}

extension CharacterSet {
    func contains(_ c: Character) -> Bool {
        let scalars = String(c).unicodeScalars
        guard scalars.count == 1 else { return false }
        return contains(scalars.first!)
    }
}

extension ParserCombinator {
    static func run3() {
        let digit = character { CharacterSet.decimalDigits.contains($0) }
        print(digit.run("456"))
    }
}

extension Parser {
    var many: Parser<[Result]> {
        return Parser<[Result]> { input in
            var result: [Result] = []
            var remainder = input
            while let (element, newRemainder) = self.parse(remainder) {
                result.append(element)
                remainder = newRemainder
            }
            return (result, remainder)
        }
    }
}

extension ParserCombinator {
    static func run4() {
        let digit = character { CharacterSet.decimalDigits.contains($0) }
        print(digit.many.run("123"))
    }
}

extension Parser {
    func map<T>(_ transform: @escaping (Result) -> T) -> Parser<T> {
        return Parser<T> { input in
            guard let (result, remainder) = self.parse(input) else { return nil }
            return (transform(result), remainder)
        }
    }
}

extension ParserCombinator {
    static func run5() {
        let digit = character { CharacterSet.decimalDigits.contains($0) }
        let integer = digit.many.map { Int(String($0))! }
        print(integer.run("123"))
        print(integer.run("123abc"))
    }
}

extension Parser {
    func followed<A>(by other: Parser<A>) -> Parser<(Result, A)> {
        return Parser<(Result, A)> { input in
            guard let (result1, remainder1) = self.parse(input) else { return nil }
            guard let (result2, remainder2) = other.parse(remainder1) else { return nil }
            return ((result1, result2), remainder2)
        }
    }
}

extension ParserCombinator {
    static func run6() {
        let digit = character { CharacterSet.decimalDigits.contains($0) }
        let integer = digit.many.map { Int(String($0))! }
        let multiplication = integer
            .followed(by: character { $0 == "*" })
            .followed(by: integer)
        print(multiplication.run("2*3"))
        
        let multiplication2 = multiplication.map { $0.0 * $1 }
        print(multiplication2.run("2*3"))
    }
}
#if false
func multiply(lhs: (Int, Character), rhs: Int) -> Int {
    return lhs.0 * rhs
}
#endif
func multiply(_ x: Int, _ op: Character, _ y: Int) -> Int {
    return x * y
}

func curriedMultiply(_ x: Int) -> (Character) -> (Int) -> Int {
    return { op in
        return { y in
            return x * y
        }
    }
}

extension ParserCombinator {
    static func run7() {
        print(curriedMultiply(2)("*")(3))
    }
}

func curry<A, B, C>(_ f: @escaping (A, B) -> C) -> (A) -> (B) -> C {
    return { a in { b in f(a, b) } }
}

extension ParserCombinator {
    static func run8() {
        let digit = character { CharacterSet.decimalDigits.contains($0) }
        let integer = digit.many.map { Int(String($0))! }
        let p1 = integer.map(curriedMultiply)
        let p2 = p1.followed(by: character { $0 == "*" })
        let p3 = p2.map { f, op in f(op) }
        let p4 = p3.followed(by: integer)
        let p5 = p4.map { f, y in f(y) }
        print(p5.run("2*3"))
        
        let multiplication3 = integer.map(curriedMultiply)
            .followed(by: character { $0 == "*" }).map { f, op in f(op) }
            .followed(by: integer).map { f, y in f(y) }
        print(multiplication3.run("4*5"))
    }
}

infix operator <*>: SequencePrecedence

precedencegroup SequencePrecedence {
    associativity: left
    higherThan: AdditionPrecedence
}

//func <*>(lhs: Parser<...>, rhs: Parser<...>) -> Parser<...> {
//    return lhs.followed(by: rhs).map { f, x in f(x) }
//}

func <*><A, B>(lhs: Parser<(A) -> B>, rhs: Parser<A>) -> Parser<B> {
    return lhs.followed(by: rhs).map { f, x in f(x) }
}

extension ParserCombinator {
    static func run9() {
        let digit = character { CharacterSet.decimalDigits.contains($0) }
        let integer = digit.many.map { Int(String($0))! }
        let multiplication4 = integer.map(curriedMultiply)<*>character { $0 == "*" }<*>integer
        print(multiplication4.run("3*7"))
    }
}

infix operator <^>: SequencePrecedence
func <^><A, B>(lhs: @escaping (A) -> B, rhs: Parser<A>) -> Parser<B> {
    return rhs.map(lhs)
}

extension ParserCombinator {
    static func run10() {
        let digit = character { CharacterSet.decimalDigits.contains($0) }
        let integer = digit.many.map { Int(String($0))! }
        let multiplication5 = curriedMultiply<^>integer<*>character { $0 == "*" }<*>integer
        print(multiplication5.run("5*7"))
        
//        print(multiply(integer, character { $0 == "*" }, integer)
    }
}

infix operator *>: SequencePrecedence
func *><A, B>(lhs: Parser<A>, rhs: Parser<B>) -> Parser<B> {
    return curry({ _, y in y })<^>lhs<*>rhs
}

infix operator <*: SequencePrecedence
func <*<A, B>(lhs: Parser<A>, rhs: Parser<B>) -> Parser<A> {
    return curry({x, _ in x})<^>lhs<*>rhs
}

extension Parser {
    func or(_ other: Parser<Result>) -> Parser<Result> {
        return Parser<Result> { input in
            return self.parse(input) ?? other.parse(input)
        }
    }
}

extension ParserCombinator {
    static func run11() {
        let star = character { $0 == "*" }
        let plus = character { $0 == "+" }
        let starOrPlus = star.or(plus)
        print(starOrPlus.run("+"))
    }
}

infix operator <|>
func <|><A>(lhs: Parser<A>, rhs: Parser<A>) -> Parser<A> {
    return lhs.or(rhs)
}

extension ParserCombinator {
    static func run12() {
        let star = character { $0 == "*" }
        let plus = character { $0 == "+" }
        print((star<|>plus).run("+"))
    }
}

extension Parser {
    #if false
    var many1: Parser<[Result]> {
        return { x in { manyX in [x] + manyX } }<^>self<*>self.many
    }
    #endif
    var many1: Parser<[Result]> {
        return curry({ [$0] + $1 })<^>self<*>self.many
    }
}

extension Parser {
    var optional: Parser<Result?> {
        return Parser<Result?> { input in
            guard let (result, remainder) = self.parse(input) else { return (nil, input) }
            return (result, remainder)
        }
    }
}

extension ParserCombinator {
    static func run13() {
        let digit = character { CharacterSet.decimalDigits.contains($0) }
        let integer = digit.many.map { Int(String($0))! }
        let multiplication = curry({ $0 * ($1 ?? 1) })<^>integer<*>(character { $0 == "*" } *> integer).optional
        let division = curry({ $0 / ($1 ?? 1) })<^>multiplication<*>(character { $0 == "/" } *> multiplication).optional
        let addition = curry({$0 + ($1 ?? 0) })<^>division<*>(character { $0 == "+" } *> division).optional
        let minus = curry({ $0 - ($1 ?? 0) })<^>addition<*>(character { $0 == "-" } *> addition).optional
        let expression = minus
        print(expression.run("2*3+4*6/2-10"))
    }
}

struct Parser2<Result> {
    typealias Stream = String.CharacterView
    let parse: (inout Stream) -> Result?
}

extension Parser2 {
    var many: Parser2<[Result]> {
        return Parser2<[Result]> { input in
            var result: [Result] = []
            while let element = self.parse(&input) {
                result.append(element)
            }
            return result
        }
    }
}

extension Parser2 {
    func or(_ other: Parser2<Result>) -> Parser2<Result> {
        return Parser2<Result> { input in
            let original = input
            if let result = self.parse(&input) { return result }
            input = original
            return other.parse(&input)
        }
    }
}

