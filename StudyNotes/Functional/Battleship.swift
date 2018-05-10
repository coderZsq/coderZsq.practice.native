//
//  Battleship.swift
//  Functional
//
//  Created by 朱双泉 on 2018/5/8.
//  Copyright © 2018 Castie!. All rights reserved.
//

import Foundation

typealias Distance = Double

struct Position {
    var x: Double
    var y: Double
}

extension Position {
    func within(range: Distance) -> Bool {
        return sqrt(x * x + y * y) < range
    }
    func minus(_ p: Position) -> Position {
        return Position(x: x - p.x, y: y - p.y)
    }
    var length: Double {
        return sqrt(x * x + y * y)
    }
}

struct Ship {
    var position: Position
    var firingRange: Distance
    var unsafeRange: Distance
}

#if false
extension Ship {
    func canEngage(ship target: Ship) -> Bool {
        let dx = target.position.x - position.x
        let dy = target.position.y - position.y
        let targetDistance = sqrt(dx * dx + dy + dy)
        return targetDistance <= firingRange
    }
    func canSafelyEngage(ship target: Ship) -> Bool {
        let dx = target.position.x - position.x
        let dy = target.position.y - position.y
        let targetDistance = sqrt(dx * dx + dy * dy)
        return targetDistance <= firingRange && targetDistance > unsafeRange
    }
    func canSafelyEngage(ship target: Ship, firendly: Ship) -> Bool {
        let dx = target.position.x - position.x
        let dy = target.position.y - position.y
        let targetDistance = sqrt(dx * dx + dy * dy)
        let friendlyDx = firendly.position.x - target.position.x
        let friendlyDy = firendly.position.y - target.position.y
        let friendlyDistance = sqrt(friendlyDx * friendlyDx + friendlyDy * friendlyDy)
        return targetDistance <= firingRange && targetDistance > unsafeRange && friendlyDistance > unsafeRange
    }
    func canSafelyEngage2(ship target: Ship, friendly: Ship) -> Bool {
        let targetDistance = target.position.minus(position).length
        let friendlyDistance = friendly.position.minus(target.position).length
        return targetDistance <= firingRange && targetDistance > unsafeRange && friendlyDistance > unsafeRange
    }
}
#endif

#if false
typealias Region = (Position) -> Bool

func circle(radius: Distance) -> Region {
    return {point in point.length <= radius}
}

func circle2(radius: Distance, center: Position) -> Region {
    return {point in point.minus(center).length <= radius}
}

func shift(_ region: @escaping Region, by offset: Position) -> Region {
    return {point in region(point.minus(offset))}
}

let shifted = shift(circle(radius: 10), by: Position(x: 5, y: 5))

func invert(_ region: @escaping Region) -> Region {
    return {point in !region(point)}
}

func intersect(_ region: @escaping Region, with other: @escaping Region) -> Region {
    return {point in region(point) && other(point)}
}

func union(_ region: @escaping Region, with other: @escaping Region) -> Region {
    return {point in region(point) || other(point)}
}

func subtract(_ region: @escaping Region, from original: @escaping Region) -> Region {
    return intersect(original, with: invert(region))
}

extension Ship {
    func canSafelyEngage(ship target: Ship, friendly: Ship) -> Bool {
        let rangeRegion = subtract(circle(radius: unsafeRange), from: circle(radius: firingRange))
        let fireRegion = shift(rangeRegion, by: position)
        let friendlyRegion = shift(circle(radius: unsafeRange), by: friendly.position)
        let resultRegion = subtract(friendlyRegion, from: fireRegion)
        return resultRegion(target.position)
    }
}
#endif

struct Region {
    let lookup: (Position) -> Bool
}


