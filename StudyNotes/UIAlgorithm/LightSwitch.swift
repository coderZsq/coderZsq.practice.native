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
    private var matrix: Matrix
    var lights = [Int]()
    
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
    
    init(matrix: Matrix) {
        self.matrix = matrix
        puzzle = [[Int]](repeating: [Int](repeating: 0, count: matrix.columns + 2), count: matrix.rows + 2)
        for r in 0..<matrix.rows + 1 {
            puzzle[r][0] = 0
            puzzle[r][7] = 0
        }
        for c in 1..<matrix.columns + 1 {
            puzzle[0][c] = 0
        }
        for r in 1..<matrix.rows + 1 {
            for c in 1..<matrix.columns + 1 {
                puzzle[r][c] = 2.arc4random
                lights.append(puzzle[r][c])
            }
        }
        for r in 0..<matrix.rows + 2 {
            for c in 0..<matrix.columns + 2 {
                print(puzzle[r][c], terminator: "")
            }
            print()
        }
    }
}
