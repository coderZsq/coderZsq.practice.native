//
//  Immutable.swift
//  Functional
//
//  Created by 朱双泉 on 2018/5/11.
//  Copyright © 2018 Castie!. All rights reserved.
//

import Foundation

//var x: Int = 1
//let y: Int = 2

struct PointStruct {
    var x: Int
    var y: Int
}

var structPoint = PointStruct(x: 1, y: 2)
var sameStructPoint = structPoint
//sameStructPoint.x = 3

class PointClass {
    var x: Int
    var y: Int
    
    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
}

var classPoint = PointClass(x: 1, y: 2)
var sameClassPoint = classPoint
//sameClassPoint.x = 3

func setStructToOrigin(point: PointStruct) -> PointStruct {
    var newPoint = point
    newPoint.x = 0
    newPoint.y = 0
    return newPoint
}

var structOrigin = setStructToOrigin(point: structPoint)

func setClassToOrigin(point: PointClass) -> PointClass {
    point.x = 0
    point.y = 0
    return point
}

var classOrigin = setClassToOrigin(point: classPoint)

extension PointStruct {
    mutating func setStructToOrigin() {
        x = 0
        y = 0
    }
}

class Immutable {
    static func run() {
        var myPoint = PointStruct(x: 100, y: 100)
        let otherPoint = myPoint
        myPoint.setStructToOrigin()
        print(otherPoint)
        print(myPoint)
    }
}

let immutablePoint = PointStruct(x: 0, y: 0)

var mutablePoint = PointStruct(x: 1, y: 1)
//mutablePoint.x = 3

struct immutablePointStruct {
    let x: Int
    let y: Int
}

var immutablePoint2 = immutablePointStruct(x: 1, y: 1)
//immutablePoint2.x = 3

//immutablePoint2 = immutablePointStruct(x: 2, y: 2)

func sum(inetegers: [Int]) -> Int {
    var result = 0
    for x in inetegers {
        result += x
    }
    return result
}


