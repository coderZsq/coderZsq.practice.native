//
//  OptionalValue.swift
//  Functional
//
//  Created by 朱双泉 on 2018/5/10.
//  Copyright © 2018 Castie!. All rights reserved.
//

import Foundation

let cities = ["Paris" : 2241, "Madrid" : 3165, "Amsterdam" : 827, "Berlin" : 3562]

class OptionalValue {
    
    static func run() {
        
        //        Value of optional type 'Int?' not unwrapped; did you mean to use '!' or '?'?
        //        let madridPopulation: Int = cities["Madrid"]
        //
        //        let madridPopulation: Int? = cities["Madrid"]
        //        if madridPopulation != nil {
        //            print("The population of Madrid is \(madridPopulation! * 1000)")
        //        } else {
        //            print("Unknown city: Madrid")
        //        }
        
        if let madridPopulation = cities["Madrid"] {
            print("The population of Madrid is \(madridPopulation * 1000)")
        } else {
            print("Unknown city: Madrid")
        }
    }
}
#if false
    infix operator ??
    
    func ??<T>(optional: T?, defaultValue: T) -> T {
        if let x = optional {
            return x
        } else {
            return defaultValue
        }
    }
#endif

extension OptionalValue {
    static func run2() {
        let cache = ["test.swift" : 1000]
        let defalutValue = 2000
        _ = cache["hello.swift"] ?? defalutValue
    }
}

#if false
    func ??<T>(optional: T?, defaultValue: () -> T) -> T {
        if let x = optional {
            return x
        } else {
            return defaultValue()
        }
    }
    
    //myOptional ?? {myDefaultValue}
#endif

#if false
    infix operator ??
    
    func ??<T>(optional: T?, defaultValue: @autoclosure () throws -> T) rethrows -> T {
        if let x = optional {
            return x
        } else {
            return try defaultValue()
        }
    }
#endif

struct Order {
    let orderNumber: Int
    let person: Person?
}

struct Person{
    let name: String
    let address: Address?
}

struct Address {
    let streetName: String
    let city: String
    let state: String?
}

extension OptionalValue {
    static func run3() {
        let order = Order(orderNumber: 42, person: nil)
        //        if let person = order.person {
        //            if let address = person.address {
        //                if let state = address.state {
        //                    print("Got a state: \(state)")
        //                }
        //            }
        //        }
        if let myState = order.person?.address?.state {
            print("This order will be shipped to \(myState)")
        } else {
            print("Unknown person, address, or state.")
        }
    }
}

extension OptionalValue {
    static func run4() {
        let madridPopulation = cities["Madrid"]
        switch madridPopulation {
        case 0?: print("Nobody in Madrid")
        case (1..<1000)?: print("Less than a million in Madrid")
        case let x?: print("\(x) people in Madrid")
        case nil: print("We don't know about Madrid")
        }
    }
}

func populationDescription(for city: String) -> String? {
    guard let population = cities[city] else { return nil }
    return "The population of Madrid is \(population)"
}

//_ = populationDescription(for: "Madrid")
#if false
    func increment(optional: Int?) -> Int? {
        guard let x = optional else { return nil }
        return x + 1
    }
#endif
extension Optional {
    func map<U>(_ transform: (Wrapped) -> U) -> U? {
        guard let x = self else { return nil }
        return transform(x)
    }
}

func increment(optional: Int?) -> Int? {
    return optional.map {$0 + 1}
}

let x: Int? = 3
let y: Int? = nil
//Binary operator '+' cannot be applied to two 'Int?' operands
//let z: Int? = x + y

func add(_ optionalX: Int?, _ optionalY: Int?) -> Int? {
    if let x = optionalX {
        if let y = optionalY {
            return x + y
        }
    }
    return nil
}

func add2(_ optionalX: Int?, _ optionalY: Int?) -> Int? {
    if let x = optionalX, let y = optionalY {
        return x + y
    }
    return nil
}

func add3(_ optionalX: Int?, _ optionalY: Int?) -> Int? {
    guard let x = optionalX, let y = optionalY else {return nil}
    return x + y
}

let capitals = [
    "France" : "Paris",
    "Spain" : "Madrid",
    "The Netherlands" : "Amsterdam",
    "Belglum" : "Brussels"
]

func populationOfCapital(country: String) -> Int? {
    guard let capital = capitals[country], let population = cities[capital] else { return nil }
    return population * 1000
}

extension Optional {
    func flatMap<U>(_ transform: (Wrapped) -> U?) -> U? {
        guard let x = self else { return nil }
        return transform(x)
    }
}

func add4(_ optionalX: Int?, _ optionalY: Int?) -> Int? {
    return optionalX.flatMap { x in
        optionalY.flatMap { y in
            return x + y
        }
    }
}

func populationOfCapital2(country: String) -> Int? {
    return capitals[country].flatMap { capital in
        cities[capital].flatMap { population in
            population * 1000
        }
    }
}

func populationOfCapital3(country: String) -> Int? {
    return capitals[country].flatMap { capital in
        cities[capital]
        }.flatMap { population in
            population * 1000
    }
}
