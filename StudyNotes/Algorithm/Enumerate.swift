//
//  Enumerate.swift
//  Algorithm
//
//  Created by 朱双泉 on 2018/5/18.
//  Copyright © 2018 Castie!. All rights reserved.
//

import Foundation

func money100chicken100() {
    for x in 0...100 {
        for y in 0...(100 - x) {
            let z = 100 - x - y
            if z % 3 == 0, 5 * x + 3 * y + z / 3 == 100 {
                print("(\(x), \(y), \(z) is solution")
            }
        }
    }
}

var puzzle = [[Int]](repeating: [Int](repeating: 0, count: 8), count: 6)
var press = [[Int]](repeating: [Int](repeating: 0, count: 8), count: 6)

func guess() -> Bool {
    for r in 1..<5 {
        for c in 1..<7 {
            press[r + 1][c] = (puzzle[r][c] + press[r][c] + press[r - 1][c] + press[r][c - 1] + press[r][c + 1]) % 2
        }
    }
    for c in 1..<7 {
        if (press[5][c - 1] + press[5][c] + press[5][c + 1] + press[4][c]) % 2 != puzzle[5][c] {
            return false
        }
    }
    return true
}

func enumerate() {
    var c = 1
    for _ in 1..<7 {
        press[1][c] = 0
        while (guess() == false) {
            press[1][1] += 1
            c = 1
            while press[1][c] > 1 {
                press[1][c] = 0
                c += 1
                press[1][c] += 1
            }
        }
        c += 1
    }
}

class Enumerate {
    
    static func main() {
        let cases = 3
        for r in 0..<6 {
            press[r][0] = 0
            press[r][7] = 0
        }
        for c in 1..<7 {
            press[0][c] = 0
        }
        for i in 0..<cases {
            for r in 1..<6 {
                for c in 1..<7 {
                    puzzle[r][c] = 0
                }
            }
            enumerate()
            print("PUZZLE #\(i + 1)")
            for r in 1..<6 {
                for c in 1..<7 {
                    print(puzzle[r][c], terminator: "")
                }
                print()
            }
        }
    }
}
