//
//  main.swift
//  10-下标
//
//  Created by 朱双泉 on 2019/8/9.
//  Copyright © 2019 Castie!. All rights reserved.
//

// MARK: - 下标 (subscript)

do {
    class Point {
        var x = 0.0, y = 0.0
        subscript(index: Int) -> Double {
            set{
                if index == 0 {
                    x = newValue
                } else if index == 1 {
                    y = newValue
                }
            }
            get {
                if index == 0 {
                    return x
                } else if index == 1 {
                    return y
                }
                return 0
            }
        }
    }
    var p = Point()
    /*
     0x1000016ac <+252>:  callq  0x100002a30               ; subscript.setter : (Swift.Int) -> Swift.Double in Point #1 in _0_下标 at main.swift:15
     */
    p[0] = 11.1
    p[1] = 22.2
    print(p.x)
    print(p.y)
    /*
     0x10000195f <+943>:  callq  0x100002ba0               ; subscript.getter : (Swift.Int) -> Swift.Double in Point #1 in _0_下标 at main.swift:22
     */
    print(p[0])
    print(p[1])
}

// MARK: - 下标的细节

do {
    class Point {
        var x = 0.0, y = 0.0
        subscript(index: Int) -> Double {
            get {
                if index == 0 {
                    return x
                } else if index == 1 {
                    return y
                }
                return 0
            }
        }
    }
}

do {
    class Point {
        var x = 0.0, y = 0.0
        subscript(index: Int) -> Double {
            if index == 0 {
                return x
            } else if index == 1 {
                return y
            }
            return 0
        }
    }
}

do {
    class Point {
        var x = 0.0, y = 0.0
        subscript(index i: Int) -> Double {
            if i == 0 {
                return x
            } else if i == 1 {
                return y
            }
            return 0
        }
    }
    var p = Point()
    p.y = 22.2
    print(p[index: 1])
}

do {
    class Sum {
        static subscript(v1: Int, v2: Int) -> Int {
            return v1 + v2
        }
    }
    print(Sum[10, 20])
}

// MARK: - 结构体, 类作为返回值对比

do {
    class Point {
        var x = 0, y = 0
    }
    class PointManager {
        var point = Point()
        subscript(index: Int) -> Point {
            get { point }
        }
    }
    var pm = PointManager()
    pm[0].x = 11
    pm[0].y = 22
    print(pm[0])
    print(pm.point)
}

do {
    struct Point {
        var x = 0, y = 0
    }
    class PointManager {
        var point = Point()
        subscript(index: Int) -> Point {
            set { point = newValue }
            get { point }
        }
    }
    var pm = PointManager()
    pm[0].x = 11
//    pm[0] = Point(x: 11, y: pm[0].y)
    pm[0].y = 22
    print(pm[0])
    print(pm.point)
}

// MARK: - 接收多个参数的下标

do {
    class Grid {
        var data = [
            [0, 1, 2],
            [3, 4, 5],
            [6, 7, 8]
        ]
        subscript(row: Int, column: Int) -> Int {
            set {
                guard row >= 0 && row < 3 && column >= 0 && column < 3 else {
                    return
                }
                data[row][column] = newValue
            }
            get {
                guard row >= 0 && row < 3 && column >= 0 && column < 3 else {
                    return 0
                }
                return data[row][column]
            }
        }
    }
    var grid = Grid()
    grid[0, 1] = 77
    grid[1, 2] = 88
    grid[2, 0] = 99
    print(grid.data)
}
