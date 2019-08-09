//
//  main.swift
//  09-方法
//
//  Created by 朱双泉 on 2019/8/9.
//  Copyright © 2019 Castie!. All rights reserved.
//

// MARK: - 方法 (Method)

do {
    class Car {
        static var count = 0
        init() {
            Car.count += 1
        }
        static func getCount() -> Int {
            count
//            self.count
//            Car.self.count
//            Car.count
        }
    }
    let c0 = Car()
    let c1 = Car()
    let c2 = Car()
    print(Car.getCount())
}

// MARK: - mutating

do {
    struct Point {
        var x = 0.0, y = 0.0
        mutating func moveBy(deltaX: Double, deltaY: Double) {
            x += deltaX
            y += deltaY
            self = Point(x: x + deltaX, y: y + deltaY)
        }
    }
}

do {
    enum StateSwitch {
        case low, middle, high
        mutating func next() {
            switch self {
            case .low:
                self = .middle
            case .middle:
                self = .high
            case .high:
                self = .low
            }
        }
    }
}

// MARK: - @discardableResult

do {
    struct Point {
        var x = 0.0, y = 0.0
        @discardableResult mutating
        func moveX(deltaX: Double) -> Double {
            x += deltaX
            return x
        }
    }
    var p = Point()
    p.moveX(deltaX: 10)
}

do {
    @discardableResult
    func get() -> Int {
        return 10
    }
    get()
}
