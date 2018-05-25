//
//  Array2D.swift
//  DataStructure
//
//  Created by 朱双泉 on 2018/5/25.
//  Copyright © 2018 Castie!. All rights reserved.
//

import Foundation

extension Array2D {
    
    #if false
    static func example() {
        var cookie = [[Int]]()
        for _ in 1...9 {
            var row = [Int]()
            for _ in 1...7 {
                row.append(0)
            }
            cookie.append(row)
        }
        
        let myCookie = cookie[3][6]
        
        var cookies = [[Int]](repeating: [Int](repeating: 0, count: 7), count: 9)
        
        func dim<T>(_ count: Int, _ value: T) -> [T] {
            return [T](repeating: value, count: count)
        }
        
        var cookies2 = dim(9, dim(7, 0))
        
        var cookies3 = dim(9, dim(7, "yum"))
        
        var threeDimensions = dim(2, dim(3, dim(4, 0)))
        
        var cookies4 = Array2D<Int>(columns: 9, rows: 7, initialValue: 0)
        
        let myCookie2 = cookies4[3, 4]
        
        cookies4[3, 4] = 5
    }
    #endif
}

public struct Array2D<T> {
    public let columns: Int
    public let rows: Int
    fileprivate var array: [T]
    
    public init(columns: Int, rows: Int, initialValue: T) {
        self.columns = columns
        self.rows = rows
        array = .init(repeatElement(initialValue, count: rows * columns))
    }
    
    public subscript(column: Int, row: Int) -> T {
        get {
            precondition(column < columns, "Column \(column) Index is out of range. Array<T>(columns: \(columns), rows:\(rows))")
            precondition(row < rows, "Row \(row) Index is out of range. Array<T>(columns: \(columns), rows:\(rows))")
            return array[row * columns + column]
        }
        set {
            precondition(column < columns, "Column \(column) Index is out of range. Array<T>(columns: \(columns), rows:\(rows))")
            precondition(row < rows, "Row \(row) Index is out of range. Array<T>(columns: \(columns), rows:\(rows))")
            array[row * columns + column] = newValue
        }
    }
}


