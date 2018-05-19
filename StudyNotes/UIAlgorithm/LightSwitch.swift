//
//  LightSwitch.swift
//  UIAlgorithm
//
//  Created by 朱双泉 on 2018/5/18.
//  Copyright © 2018 Castie!. All rights reserved.
//

import Foundation

struct Matrix {
    var rows: Int
    var columns: Int
}

struct LightSwitch {
    
    private var puzzle: [[Int]]
    private var press: [[Int]]
    private var matrix: Matrix
    var lights = [Int]()
    var hints = [Int]()
    
    mutating func lightUp(index: Array<Any>.Index?) {
        guard let index = index else { return }
        var m = Matrix(rows: 0, columns: 0)
        if index <= matrix.rows {
            m.columns = index + 1
        } else {
            m.columns += index % matrix.columns + 1
        }
        for i in 0...index {
            if i % matrix.columns == 0 {
                m.rows += 1
            }
        }
        puzzle[m.rows][m.columns] = puzzle[m.rows][m.columns] == 0 ? 1 : 0
        puzzle[m.rows + 1][m.columns] = puzzle[m.rows + 1][m.columns] == 0 ? 1 : 0
        puzzle[m.rows][m.columns + 1] = puzzle[m.rows][m.columns + 1] == 0 ? 1 : 0
        puzzle[m.rows - 1][m.columns] = puzzle[m.rows - 1][m.columns] == 0 ? 1 : 0
        puzzle[m.rows][m.columns - 1] = puzzle[m.rows][m.columns - 1] == 0 ? 1 : 0
        lights.removeAll()
        for r in 1..<matrix.rows + 1 {
            for c in 1..<matrix.columns + 1 {
                lights.append(puzzle[r][c])
            }
        }
    }
    
    mutating func guess() -> Bool {
        for r in 1..<matrix.rows {
            for c in 1..<matrix.columns + 1 {
                press[r + 1][c] = (puzzle[r][c] + press[r][c] + press[r - 1][c] + press[r][c - 1] + press[r][c + 1]) % 2
            }
        }
        for c in 1..<matrix.columns + 1 {
            if (press[matrix.rows][c - 1] + press[matrix.rows][c] + press[matrix.rows][c + 1] + press[matrix.rows - 1][c]) % 2 != puzzle[matrix.rows][c] {
                return false
            }
        }
        return true
    }
    
    mutating func enumerate() {
        var c = 1
        for _ in 1..<matrix.columns + 1 {
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
    
    init(matrix: Matrix) {
        self.matrix = matrix
        puzzle = [[Int]](repeating: [Int](repeating: 0, count: matrix.columns + 2), count: matrix.rows + 2)
        press = [[Int]](repeating: [Int](repeating: 0, count: matrix.columns + 2), count: matrix.rows + 2)
        for r in 1..<matrix.rows + 1 {
            for c in 1..<matrix.columns + 1 {
                puzzle[r][c] = 2.arc4random
                lights.append(puzzle[r][c])
            }
        }
        enumerate()
        for r in 1..<matrix.rows + 1 {
            for c in 1..<matrix.columns + 1 {
                hints.append(press[r][c])
            }
        }
        print("========")
        for r in 0..<matrix.rows + 2 {
            for c in 0..<matrix.columns + 2 {
                print(puzzle[r][c], terminator: "")
            }
            print()
        }
        print("========")
    }
}
